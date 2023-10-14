{ config, self, withSystem, ... }:
let
  inherit (self) inputs homeModules;
  inherit (inputs) haumea nix-darwin home-manager;
  # inherit (self.lib.home-manager) mkHomeConfiguration;
  inherit (self.lib.utils) flattenTree;
  l = inputs.nixpkgs.lib // builtins;

  commonModules = [ ] ++ homeModules;

  profiles = haumea.lib.load {
    src = ../modules/profiles/home;
    loader = haumea.lib.loaders.path;
  };

  suites = import ../modules/suites/home.nix { inherit profiles; };

  mkHomeConfiguration = username:
    { pkgs, configuration ? ./${username}/home.nix }:
    let
      modules = homeModules ++ [ configuration ];
      extraSpecialArgs = { inherit inputs profiles suites; };
    in home-manager.lib.homeManagerConfiguration {
      inherit pkgs modules extraSpecialArgs;
    };

in {
  flake.homeConfigurations = l.genAttrs config.systems (sys:
    withSystem sys ({ pkgs, system, ... }: {
      # ethan = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      #   modules = homeModules ++ [ ./ethan/home.nix ];
      # };

      ethan = mkHomeConfiguration "ethan" { inherit pkgs; };
    }));
}
