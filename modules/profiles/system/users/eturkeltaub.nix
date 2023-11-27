{ homeConfigurations, ... }: {
  tilde.host.primaryUser = {
    username = "eturkeltaub";
    homeDirectory = "/Users/eturkeltaub";
  };

  home-manager.users = { inherit (homeConfigurations) eturkeltaub; };
}
