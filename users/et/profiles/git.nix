{ config, ... }: {
  programs.git = {
    userEmail = "et@mercury.com";
    userName = "Ethan Turkeltaub";
    signing.key = config.tilde.home.gpg.keyId;
  };
}
