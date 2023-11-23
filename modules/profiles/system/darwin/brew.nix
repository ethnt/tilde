{
  environment.systemPath = [ "/opt/homebrew/bin" ];

  homebrew = {
    enable = true;

    onActivation.cleanup = "zap";

    casks = [
      "1password"
      "bartender"
      "firefox"
      "hazel"
      "hey"
      "istat-menus"
      "iterm2"
      "logitech-options"
      "raycast"
      "rectangle"
      "spotify"
    ];

    masApps = {
      "Balance Lock" = 1019371109;
      Fantastical = 975937182;
      "Things 3" = 904280696;
      "Reeder 5" = 1529448980;
    };
  };
}
