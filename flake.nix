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
        inherit importables;

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
      };

      home = {
        inherit importables;
        users = {

        };
      };

      homeConfigurations =
        digga.lib.mkHomeConfigurations self.darwinConfigurations;
    };
}
