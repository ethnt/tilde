{ self, withSystem, ... }:
let
  inherit (self) inputs;
  inherit (inputs) nix-darwin home-manager;
  l = self.inputs.nixpkgs.lib // builtins;

  darwinModules = (l.attrValues self.darwinModules)
    ++ [ home-manager.darwinModules.home-manager ];

  mkDarwinConfiguration =
    { name, system, configuration ? ./${name}/configuration.nix, }:
    withSystem system ({ pkgs, ... }:
      let
        profiles = self.profiles.darwin;
        suites = self.suites.darwin;
        modules = darwinModules ++ [ configuration ];

        specialArgs = {
          inherit inputs profiles suites;
          inherit (self) homeConfigurations secrets;
          flake = self;
        };
      in nix-darwin.lib.darwinSystem {
        inherit pkgs system modules specialArgs;
      });
in {
  flake.darwinConfigurations = {
    eMac = mkDarwinConfiguration {
      name = "eMac";
      system = "aarch64-darwin";
    };

    mercury = mkDarwinConfiguration {
      name = "mercury";
      system = "aarch64-darwin";
    };
  };
}
