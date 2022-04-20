{ hmUsers, ... }: {
  home-manager.users = { inherit (hmUsers) ethan; };

  nix.trustedUsers = [ "ethan" ];

  users.users.ethan.home = "/Users/ethan";
}
