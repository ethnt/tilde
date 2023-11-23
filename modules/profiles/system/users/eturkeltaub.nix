{ homeConfigurations, ... }: {
  tilde.host.primaryUser = {
    username = "ethan";
    homeDirectory = "/Users/eturkeltaub";
  };

  home-manager.users = { inherit (homeConfigurations) eturkeltaub; };
}
