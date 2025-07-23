{ homeConfigurations, ... }: {
  tilde.host.primaryUser = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
  };

  home-manager.users = { ethan = homeConfigurations.work; };
}
