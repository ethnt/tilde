{ config, hmUsers, ... }: {
  home-manager.users = { inherit (hmUsers) remote; };

  tilde.system = {
    username = "eturkeltaub";
    homeDirectory = "/home/eturkeltaub";
    user = config.home-manager.users.remote;
  };
}
