{
  homebrew = {
    enable = true;

    taps = [ "homebrew/cask-drivers" ];

    casks = [
      "1password"
      "bartender"
      "dash"
      "firefox"
      "hazel"
      "istat-menus"
      "iterm2"
      "logitech-options"
      "raycast"
      "spotify"
    ];

    # Currently commenting these out because it's pretty slow
    # masApps = {
    #   "Balance Lock" = 1019371109;
    #   Fantastical = 975937182;
    #   "Tweetbot 3 for Twitter" = 1384080005;
    # };
  };
}
