{ homeConfigurations, ... }: {
  tilde.host.primaryUser = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
  };

  home-manager.users = { inherit (homeConfigurations) et; };
}
