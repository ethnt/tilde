{
  description = "tilde";

  nixConfig.extra-experimental-features = "nix-command flakes";
  nixConfig.extra-substituters =
    "https://cachix.org/api/v1/cache/tilde https://nrdxp.cachix.org https://nix-community.cachix.org";
  nixConfig.extra-trusted-public-keys =
    "tilde.cachix.org-1:vjup2ixrsWKk+v8FXCqusKWBRwU0l7EzumjnMV4n2Vg= nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-21.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-vscode-pin.url =
      "github:nixos/nixpkgs/af9cad4c9427ef795ba71aa09e05b91b8b817a75";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    digga.url = "github:divnix/digga";
    digga.inputs.darwin.follows = "darwin";
    digga.inputs.home-manager.follows = "home-manager";

    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nixpkgs-master
    , nixpkgs-vscode-pin, darwin, digga, home-manager, ... }:
    digga.lib.mkFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-darwin" "aarch64-darwin" ];

      channelsConfig.allowUnfree = true;

      channels = {
        nixpkgs = {
          imports = [ (digga.lib.importOverlays ./overlays/nixpkgs) ];
        };
        nixpkgs-unstable = { };
        nixpkgs-master = { };
        nixpkgs-vscode-pin = { };
      };

      nixos.hostDefaults.channelName = "nixpkgs";

      lib = import ./lib { lib = digga.lib // nixpkgs.lib; };

      sharedOverlays = [
        (final: prev: {
          __dontExport = true;
          lib = prev.lib.extend (lfinal: lprev: { our = self.lib; });
        })
        (import ./pkgs)
      ];

      darwin = let
        mkHost = { host, user, }: {
          modules = [
            ({ profiles, ... }: {
              imports = [ profiles.hosts.${host} profiles.users.${user} ];
            })
          ];
        };
      in {
        hostDefaults = {
          system = "x86_64-darwin";
          channelName = "nixpkgs";
          imports = [ (digga.lib.importExportableModules ./modules/system) ];
          modules = [
            { lib.our = self.lib; }
            digga.nixosModules.nixConfig
            home-manager.darwinModules.home-manager
          ];
        };

        hosts = {
          eMac = mkHost {
            host = "eMac";
            user = "ethan";
          };

          st-eturkeltaub1 = mkHost {
            host = "st-eturkeltaub1";
            user = "eturkeltaub";
          };
        };

        importables = rec {
          profiles = digga.lib.rakeLeaves ./profiles/system // {
            hosts = digga.lib.rakeLeaves ./hosts;
            users = digga.lib.rakeLeaves ./users;
          };

          suites = rec {
            base = [
              profiles.darwin.common
              profiles.darwin.system-defaults
              profiles.darwin.brew
              profiles.cachix
              profiles.shells
              profiles.networking
            ];

            fonts = with profiles.fonts; [ common pragmatapro ];

            identity = [ profiles.gpg-agent ];

            remote-builders =
              [ profiles.builders.common profiles.builders.nix-docker ];
          };
        };
      };

      home = {
        imports = [ (digga.lib.importExportableModules ./modules/home) ];
        importables = rec {
          profiles = digga.lib.rakeLeaves ./profiles/home;

          suites = with profiles; rec {
            base = [
              autojump
              broot
              bat
              direnv
              fish
              fzf
              paths
              micro
              navi
              nushell
              starship
              tmux
              tools
            ];
            development = [ asdf git vscode ];
            programming = [ elixir ruby ];
            identity = [ gnupg ];
            orchard = [ tailscale ];
          };
        };

        users = {
          ethan = { ... }: { imports = [ ./users/ethan/home.nix ]; };

          eturkeltaub = { ... }: {
            imports = [ ./users/eturkeltaub/home.nix ];
          };
        };
      };

      homeConfigurations =
        digga.lib.mkHomeConfigurations self.darwinConfigurations;

      devshell = ./shell;

      outputsBuilder = channels:
        let pkgs = channels.nixpkgs-unstable;
        in {
          checks = let
            runCodeAnalysis = name: command:
              pkgs.runCommand "tilde-${name}-check" { } ''
                cd ${self}
                ${command}
                mkdir $out
              '';
          in {
            format = runCodeAnalysis "format" ''
              ${pkgs.nixfmt}/bin/nixfmt --check ${./.}/**/*.nix
            '';

            lint = runCodeAnalysis "lint" ''
              ${pkgs.statix}/bin/statix check ${./.}
            '';
          };
        };
    };
}
