{ config, suites, secrets, ... }: {
  imports = (with suites; base ++ development ++ identity ++ work)
    ++ [ secrets.users."ethan.turkeltaub".home ] ++ [ ./profiles/vscode.nix ];

  tilde.home = {
    username = "ethan.turkeltaub";
    homeDirectory = "/Users/ethan.turkeltaub";
    gpg.keyId = "E975F001FBC704AE";
  };

  programs = {
    git = {
      userEmail = "ethan.turkeltaub@zocdoc.com";
      userName = "Ethan Turkeltaub";
      signing.key = config.tilde.home.gpg.keyId;
    };
  };

  home = {
    username = "ethan.turkeltaub";
    homeDirectory = "/Users/ethan.turkeltaub";

    stateVersion = "24.05";
  };
}
