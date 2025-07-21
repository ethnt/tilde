{ config, pkgs, suites, secrets, ... }: {
  imports = (with suites; base ++ development);

  tilde.home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    gpg.keyId = "E975F001FBC704AE";
  };

  home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";

    stateVersion = "24.05";
  };
}
