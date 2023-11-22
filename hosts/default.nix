{ self, withSystem, ... }:
let
  inherit (self.inputs) nix-darwin home-manager;
  l = self.inputs.nixpkgs.lib // builtins;

  mkDarwinConfiguration =
    { name, system, configuration ? ./${name}/configuration.nix }:
    withSystem system ({ pkgs, ... }:
      let
        modules = (l.attrValues self.darwinModules) ++ [
          home-manager.darwinModules.home-manager
          ({ nixpkgs = { inherit pkgs; }; })
          ({ home-manager.extraSpecialArgs = { suites = self.suites.home; }; })
          configuration
        ];

        specialArgs = {
          suites = self.suites.darwin;
          profiles = self.profiles.darwin;
          homeConfigurations = self.homeConfigurations;
        };
      in nix-darwin.lib.darwinSystem { inherit system modules specialArgs; });
in {
  flake.darwinConfigurations = {
    eMac = mkDarwinConfiguration {
      name = "eMac";
      system = "aarch64-darwin";
    };
  };
}
