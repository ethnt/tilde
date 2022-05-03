{ config, hmUsers, ... }: {
  home-manager.users = { inherit (hmUsers) eturkeltaub; };

  nix.trustedUsers = [ "eturkeltaub" ];

  users.users.eturkeltaub.home = "/Users/eturkeltaub";
}
