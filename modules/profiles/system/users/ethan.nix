{
  home-manager.users.ethan = import ../../../../users/ethan/home.nix;

  system = {
    primaryUser = "ethan";
    primaryUserHome = "/Users/ethan";
  };
}
