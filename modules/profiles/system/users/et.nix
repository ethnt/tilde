{
  home-manager.users.et = import ../../../../users/et/home.nix;

  system = {
    primaryUser = "et";
    primaryUserHome = "/Users/et";
  };
}
