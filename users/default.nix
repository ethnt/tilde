{ self, withSystem, ... }:
let
  inherit (self) inputs homeModules;
  inherit (inputs) home-manager nixvim;

  l = inputs.nixpkgs.lib // builtins;

  commonModules = (l.attrValues homeModules)
    ++ [ nixvim.homeManagerModules.nixvim ];

  mkHomeManagerConfiguration =
    { username, system, configuration ? ./${username}/home.nix }:
    withSystem system ({ pkgs, ... }:
      (home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = commonModules ++ [ configuration ];
        extraSpecialArgs = {
          inherit inputs;
          currentSystem = system;
          profiles = self.profiles.home;
          suites = self.suites.home;
          inherit (self) secrets;
        };
      }));
in rec {
  flake = {
    homeConfigurations = {
      ethan = mkHomeManagerConfiguration {
        username = "ethan";
        system = "aarch64-darwin";
      };
      et = mkHomeManagerConfiguration {
        username = "et";
        system = "aarch64-darwin";
      };
    };
  };
}
