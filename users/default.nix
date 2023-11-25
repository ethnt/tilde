{ config, self, withSystem, ... }:
let
  inherit (self) inputs homeModules;
  inherit (inputs) home-manager;

  l = inputs.nixpkgs.lib // builtins;

  commonModules = l.attrValues homeModules;

  mkHomeConfiguration = { username, configuration ? ./${username}/home.nix }: {
    imports = commonModules ++ [ configuration ];
  };
in rec {
  flake = {
    homeConfigurations = {
      ethan = mkHomeConfiguration { username = "ethan"; };
      eturkeltaub = mkHomeConfiguration { username = "eturkeltaub"; };
      remote = mkHomeConfiguration { username = "remote"; };
    };

    homeConfigurationsPortable = l.genAttrs config.systems (sys:
      withSystem sys ({ pkgs, ... }:
        l.mapAttrs (_name: cfg:
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ cfg ];
            extraSpecialArgs = {
              inherit inputs;
              profiles = self.profiles.home;
              suites = self.suites.home;
            };
          }) flake.homeConfigurations));
  };
}
