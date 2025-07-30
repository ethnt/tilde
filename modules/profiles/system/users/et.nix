{ homeConfigurations, ... }: {
  tilde.host.primaryUser = {
    username = "et";
    homeDirectory = "/Users/et";
  };

  home-manager.users = { inherit (homeConfigurations) et; };
}
