{
  description = "tilde";

  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    extra-substituters =
      "https://cachix.org/api/v1/cache/tilde https://nix-community.cachix.org";
    extra-trusted-public-keys =
      "tilde.cachix.org-1:vjup2ixrsWKk+v8FXCqusKWBRwU0l7EzumjnMV4n2Vg=  nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
  };

  inputs = {
    nixpkgs.follows = "nixos-unstable";

    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-23.11";

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
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];

      imports = [
        ./lib

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

          overlays = [ (import ./pkgs) ];
        };
      };
    };
}
