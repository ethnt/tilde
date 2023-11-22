{
  description = "tilde";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    haumea.url = "github:nix-community/haumea/v0.2.2";
    haumea.inputs.nixpkgs.follows = "nixpkgs";

    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";

    treefmt.url = "github:numtide/treefmt-nix";
    treefmt.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, flake-parts, haumea, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];

      imports = [
        ./lib

        ./modules/development/shell.nix
        ./modules/development/treefmt.nix
        ./modules/development/dhall.nix

        # ./modules/darwin/default.nix
        # ./modules/home/default.nix

        ./hosts
        ./users
      ];

      perSystem = { pkgs, system, ... }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;

          # TODO: Make this on a per-system basis, and maybe per-package
          config.allowUnfree = true;

          overlays = [ (import ./pkgs) ];
        };
      };

      flake = {
        modules = {
          darwin = haumea.lib.load {
            src = ./modules/darwin/src;
            loader = haumea.lib.loaders.path;
          };

          home = haumea.lib.load {
            src = ./modules/home/src;
            loader = haumea.lib.loaders.path;
          };
        };

        homeModules = builtins.mapAttrs (_: value: (import value))
          (self.lib.utils.flattenTree self.modules.home);

        darwinModules = builtins.mapAttrs (_: value: (import value))
          (self.lib.utils.flattenTree self.modules.darwin);

        profiles = {
          darwin = haumea.lib.load {
            src = ./modules/profiles/system;
            loader = haumea.lib.loaders.path;
          };

          home = haumea.lib.load {
            src = ./modules/profiles/home;
            loader = haumea.lib.loaders.path;
          };
        };

        suites = {
          darwin = import ./modules/suites/system.nix {
            profiles = self.profiles.darwin;
          };

          home =
            import ./modules/suites/home.nix { profiles = self.profiles.home; };
        };
      };
    };
}
