{ config, ... }: {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = config.programs.git.userEmail;
        name = config.programs.git.userName;
      };
      signing = {
        sign-all = true;
        backend = "gpg";
        key = config.tilde.home.gpg.keyId;
      };
    };
  };
}
