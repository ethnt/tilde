{
  programs.jujutsu = {
    enable = true;
    settings = {
      user.name = "Ethan Turkeltaub";
      signing = {
        behavior = "own";
        backend = "gpg";
      };
      revset-aliases = {
        "closest_bookmark(to)" = "heads(::to & bookmarks())";
      };

      aliases = {
        tug = [ "bookmark" "move" "--from" "closest_bookmark(@-)" "--to" "@-" ];
      };
    };
  };
}
