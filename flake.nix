{
  description = "tilde";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-21.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    darwin.url = "github:montchr/nix-darwin/add-toplevel-option-lib";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    digga.url = "github:divnix/digga/darwin-support";
    digga.inputs.darwin.follows = "darwin";
    digga.inputs.home-manager.follows = "home-manager";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    utils.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nixpkgs-master, darwin
    , digga, home-manager, utils, ... }:
    let
      importables = rec {
        profiles = {
          system = digga.lib.rakeLeaves ./profiles/system // {
            users = digga.lib.rakeLeaves ./users;
          };
          home = digga.lib.rakeLeaves ./profiles/home;
        };

        suites = with profiles; rec {
          base = [ system.darwin.common system.darwin.system-defaults ];
          terminal = [ home.fish ];
        };
      };
    in digga.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      channels = {
        nixpkgs = { };
        nixpkgs-unstable = { };
        nixpkgs-master = { };
      };

      nixos.hostDefaults.channelName = "nixpkgs-unstable";

      lib = import ./lib { lib = digga.lib // nixpkgs.lib; };

      sharedOverlays = [
        (final: prev: {
          __dontExport = true;
          lib = prev.lib.extend (final: prev: { our = self.lib; });
        })
      ];

      darwin = {
        hostDefaults = {
          system = "x86_64-darwin";
          channelName = "nixpkgs";
          modules = [
            { lib.our = self.lib; }
            digga.nixosModules.nixConfig
            home-manager.darwinModules.home-manager
          ];
        };

        imports = [ (digga.lib.importHosts ./hosts) ];

        hosts = {
          ci = { };
          eMac = { };
        };

        importables = rec {
          profiles = digga.lib.rakeLeaves ./profiles/hosts // {
            users = digga.lib.rakeLeaves ./users;
          };
          # FIXME: Using `with profiles` here doesn't work, for some reason
          suites = rec {
            base = [ profiles.darwin.common profiles.darwin.system-defaults ];
            ci = [ profiles.users.ci ];
          };
        };
      };

      home = {
        importables = rec {
          profiles = digga.lib.rakeLeaves ./profiles/home;
          suites = with profiles; rec { terminal = [ fish ]; };
        };

        users = { ci = { suites, ... }: { imports = suites.terminal; }; };
      };

      homeConfigurations =
        digga.lib.mkHomeConfigurations self.darwinConfigurations;

      devshell.modules = { pkgs, ... }: {
        packages = with pkgs; [ nixfmt statix ];
      };

      outputsBuilder = channels: {
        checks = let
          runCodeAnalysis = name: command:
            channels.nixpkgs.runCommand "tilde-${name}-check" { } ''
              cd ${self}
              ${command}
              mkdir $out
            '';
        in {
          format = runCodeAnalysis "format" ''
            ${channels.nixpkgs.nixfmt}/bin/nixfmt --check \
              $(find . -type f -name '*.nix')
          '';

          lint = runCodeAnalysis "lint" ''
            ${channels.nixpkgs.statix}/bin/statix check .
          '';
        };
      };
    };
}
