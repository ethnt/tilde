{ config, ... }: {
  programs.git = {
    userEmail = "ethan@turkeltaub.dev";
    userName = "Ethan Turkeltaub";
    signing.key = config.tilde.home.gpg.keyId;
  };
}
