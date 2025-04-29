{ config, suites, profiles, ... }: {
  imports = with suites; base ++ development ++ [ profiles.ghostty.default ];

  tilde.home = {
    username = "ethan.turkeltaub";
    homeDirectory = "/Users/ethan.turkeltaub";
    gpg = { keyId = "E975F001FBC704AE"; };
  };

  programs = {
    git = {
      userEmail = "ethan.turkeltaub@zocdoc.com";
      userName = "Ethan Turkeltaub";
      signing.key = config.tilde.home.gpg.keyId;
    };
  };

  home = {
    username = "ethan";
    homeDirectory = "/Users/ethan.turkeltaub";
    stateVersion = "24.05";
  };
}
