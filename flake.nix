{
  description = "tilde";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-21.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    nix-darwin.url = "github:montchr/nix-darwin/add-toplevel-option-lib";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    digga.url = "github:divnix/digga/darwin-support";
    digga.inputs.darwin.follows = "nix-darwin";
    digga.inputs.home-manager.follows = "home-manager";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    utils.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nixpkgs-master, nix-darwin
    , digga, home-manager, utils, ... }:
    digga.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      channels = {
        nixpkgs = { };
        nixpkgs-unstable = { };
        nixpkgs-master = { };
      };

      nixos = { hostDefaults = { channelName = "nixpkgs"; }; };
    };
}
