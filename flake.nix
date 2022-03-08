{
  description = "tilde";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-21.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    utils.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nixpkgs-master, nix-darwin
    , home-manager, utils, ... }:
    utils.lib.mkFlake {
      inherit self inputs;

      supportedSystems = [ "aarch64-darwin" "x86_64-darwin" ];

      channelsConfig.allowUnfree = true;

      channels.nixpkgs.overlaysBuilder = channels:
        [
          (final: prev: {
            unstable = nixpkgs-unstable.legacyPackages."${prev.system}";
            master = nixpkgs-master.legacyPackages."${prev.system}";
          })
        ];

      hostDefaults = {
        output = "darwinConfigurations";
        builder = nix-darwin.lib.darwinSystem;

        system = "x86_64-darwin";
        channelName = "nixpkgs";

        modules = [
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

      hosts = { vm = { }; };

      outputsBuilder = channels:
        with channels.nixpkgs; {
          devShell = mkShell { buildInputs = [ git nixfmt statix ]; };

          checks = let
            runCodeAnalysis = name: command:
              runCommand "tilde-${name}-check" { } ''
                cd ${self}
                ${command}
                mkdir $out
              '';
          in {
            format = runCodeAnalysis "format" ''
              ${nixfmt}/bin/nixfmt --check flake.nix
            '';

            lint = runCodeAnalysis "lint" ''
              ${statix}/bin/statix check --format stderr
            '';
          };
        };
    };
}
