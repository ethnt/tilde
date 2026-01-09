{
  programs.jujutsu = {
    enable = true;
    settings = {
      user.name = "Ethan Turkeltaub";
      signing = {
        behavior = "own";
        backend = "gpg";
      };
    };
  };
}
