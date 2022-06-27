{ config, hmUsers, ... }: {
  home-manager.users = { inherit (hmUsers) eturkeltaub; };

  tilde.system = {
    username = "eturkeltaub";
    homeDirectory = "/Users/eturkeltaub";
    user = config.home-manager.users.eturkeltaub;
  };

  # users.users.eturkeltaub.home = "/Users/eturkeltaub";
}
