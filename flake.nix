{
  description = "tilde";

  nixConfig = {
    extra-experimental-features = "nix-command flakes";

    extra-substituters = [
      "https://cache.e10.camp/tilde"
      "https://tilde.cachix.org"
      "https://nix-community.cachix.org"
      "https://numtide.cachix.org"
    ];

    extra-trusted-public-keys = [
      "tilde:Urwh7kyCsSsNmV1gu4sMYFVZCI0ZPwEXjxxtNH06G8U="
      "tilde.cachix.org-1:vjup2ixrsWKk+v8FXCqusKWBRwU0l7EzumjnMV4n2Vg="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    tilde-secrets.url = "git+ssh://git@github.com/ethnt/tilde-secrets";

    flake-root.url = "github:srid/flake-root";

    haumea.url = "github:nix-community/haumea";
    haumea.inputs.nixpkgs.follows = "nixpkgs";

    devenv.url = "github:cachix/devenv";
    # devenv.inputs.nixpkgs.follows = "nixpkgs";

    treefmt.url = "github:numtide/treefmt-nix";
    treefmt.inputs.nixpkgs.follows = "nixpkgs";

    pragmatapro.url = "git+ssh://git@github.com/ethnt/pragmatapro";
    pragmatapro.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    rippkgs.url = "github:replit/rippkgs";
    rippkgs.inputs.nixpkgs.follows = "nixpkgs";

    attic.url = "github:zhaofengli/attic";
    attic.inputs.nixpkgs.follows = "nixpkgs";

    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];

      imports = [
        ./lib

        ./pkgs

        ./modules/core/secrets.nix
        ./modules/core/flake-root.nix

        ./modules/development/shell.nix
        ./modules/development/treefmt.nix

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

          overlays = with inputs; [
            self.overlays.default
            pragmatapro.overlays.default
            rippkgs.overlays.default
          ];

          # TODO: Make this on a per-system basis, and maybe per-package
          config = { allowUnfree = true; };
        };
      };
    };
}
