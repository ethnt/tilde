{ config, self, withSystem, ... }:
let
  inherit (self) inputs homeModules;
  inherit (inputs) home-manager nixvim;

  l = inputs.nixpkgs.lib // builtins;

  commonModules = (l.attrValues homeModules)
    ++ [ nixvim.homeManagerModules.nixvim ];

  mkHomeConfiguration = { username, configuration ? ./${username}/home.nix }: {
    imports = commonModules ++ [ configuration ];
  };
in rec {
  flake = {
    homeConfigurations = {
      ethan = mkHomeConfiguration { username = "ethan"; };
    };

    homeConfigurationsPortable = l.genAttrs config.systems (sys:
      withSystem sys ({ pkgs, ... }:
        l.mapAttrs (_name: cfg:
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ cfg ];
            extraSpecialArgs = {
              inherit inputs;
              currentSystem = sys;
              profiles = self.profiles.home;
              suites = self.suites.home;
              inherit (self) secrets;
            };
          }) flake.homeConfigurations));
  };
}
