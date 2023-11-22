{ config, self, withSystem, ... }:
let
  inherit (self) inputs homeModules;
  inherit (inputs) home-manager;

  l = inputs.nixpkgs.lib // builtins;

  commonModules = (l.attrValues homeModules);

  mkHomeConfiguration = { username, configuration ? ./${username}/home.nix }:
    { ... }: {
      imports = commonModules ++ [ configuration ];
    };
in rec {
  flake = {
    homeConfigurations = {
      ethan = mkHomeConfiguration { username = "ethan"; };
    };

    homeConfigurationsPortable = l.genAttrs config.systems (sys:
      withSystem sys ({ pkgs, ... }: {
        ethan = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ flake.homeConfigurations.ethan ];
          extraSpecialArgs = {
            inherit inputs;
            profiles = self.profiles.home;
            suites = self.suites.home;
          };
        };
      }));
  };
}
