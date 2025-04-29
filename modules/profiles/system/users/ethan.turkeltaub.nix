{ homeConfigurations, ... }: {
  tilde.host.primaryUser = {
    username = "ethan.turkeltaub";
    homeDirectory = "/Users/ethan.turkeltaub";
  };

  home-manager.users."ethan.turkeltaub" = homeConfigurations."ethan.turkeltaub";
}
