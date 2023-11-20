{ inputs, homeConfigurations, ... }:
let
  inherit (inputs) haumea;

  homeProfiles = haumea.lib.load {
    src = ../../../../modules/profiles/home;
    loader = haumea.lib.loaders.path;
  };

  homeSuites = import ../../../../modules/suites/home.nix { profiles = homeProfiles; };
in {
  tilde.host.primaryUser = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
  };

  # TODO: Move this elsewhere
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
      profiles = homeProfiles;
      suites = homeSuites;
    };
  };

  home-manager.users = { inherit (homeConfigurations) ethan; };
}
