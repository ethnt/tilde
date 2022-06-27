{ config, hmUsers, ... }: {
  home-manager.users = { inherit (hmUsers) ethan; };

  tilde.system = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    user = config.home-manager.users.ethan;
  };

  # nix.trustedUsers = [ "ethan" ];

  # users.users.ethan.home = "/Users/ethan";
}
