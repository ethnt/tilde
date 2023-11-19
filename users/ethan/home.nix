{ config, suites, ... }: {
  imports = with suites; base ++ development ++ programming ++ identity;

  tilde.home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    gpg = { keyId = "0x690FEBBF6380166A"; };
  };

  programs.git = {
    userEmail = "ethan.turkeltaub@hey.com";
    userName = "Ethan Turkeltaub";
    signing.key = config.tilde.home.gpg.keyId;
  };

  # home.username = "ethan";
  # home.homeDirectory = "/Users/ethan";
  home.stateVersion = "23.05";
}
