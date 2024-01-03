{
  description = "tilde";

  nixConfig = {
    extra-experimental-features = "nix-command flakes";

    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://tilde.cachix.org"
      "https://numtide.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "tilde.cachix.org-1:vjup2ixrsWKk+v8FXCqusKWBRwU0l7EzumjnMV4n2Vg="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nix-darwin.url = "github:ethnt/nix-darwin/linux-builder-systems-config";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-root.url = "github:srid/flake-root";

    haumea.url = "github:nix-community/haumea/v0.2.2";
    haumea.inputs.nixpkgs.follows = "nixpkgs";

    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";

    treefmt.url = "github:numtide/treefmt-nix";
    treefmt.inputs.nixpkgs.follows = "nixpkgs";

    pragmatapro.url = "git+ssh://git@github.com/ethnt/pragmatapro";
    pragmatapro.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];

      imports = [
        ./lib

        ./pkgs

        ./modules/development/flake-root.nix
        ./modules/development/shell.nix
        ./modules/development/treefmt.nix
        ./modules/development/dhall.nix

        ./modules/darwin/default.nix
        ./modules/home/default.nix

        ./modules/profiles/default.nix
        ./modules/suites/default.nix

        ./hosts
        ./users
      ];

      perSystem = { system, ... }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;

          # TODO: Make this on a per-system basis, and maybe per-package
          config.allowUnfree = true;

          overlays = [ self.overlays.default ];
        };
      };
    };
}
