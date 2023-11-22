{
  environment.systemPath = [ "/opt/homebrew/bin" ];

  homebrew = {
    enable = true;

    onActivation.cleanup = "zap";

    brews = [ "pinentry-mac" ];

    casks = [
      "1password"
      "arc"
      "bartender"
      "dash"
      "firefox"
      "hazel"
      "hey"
      "istat-menus"
      "iterm2"
      "logitech-options"
      "raycast"
      "rectangle"
      "spotify"
      "tailscale"
      "utm"
    ];

    masApps = {
      "Balance Lock" = 1019371109;
      Fantastical = 975937182;
      "Things 3" = 904280696;
      "Reeder 5" = 1529448980;
    };
  };
}
