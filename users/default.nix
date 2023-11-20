{ config, self, withSystem, ... }:
let
  inherit (self) inputs homeModules;
  inherit (inputs) haumea home-manager;
  # inherit (self.lib.home-manager) mkHomeConfiguration;
  l = inputs.nixpkgs.lib // builtins;

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
    withSystem sys ({ pkgs, ... }: {
      # ethan = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      #   modules = homeModules ++ [ ./ethan/home.nix ];
      # };

      ethan = mkHomeConfiguration "ethan" { inherit pkgs; };
    }));
}
