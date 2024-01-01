{ lib, ... }: {
  environment.systemPath = [ "/opt/homebrew/bin" ];

  homebrew = {
    enable = true;

    onActivation.cleanup = lib.mkDefault "zap";

    casks = [
      "1password"
      "bartender"
      "firefox"
      "hazel"
      "istat-menus"
      "iterm2"
      "logitech-options"
      "raycast"
      "rectangle"
      "spotify"
      "zoom"
    ];

    masApps = {
      "Balance Lock" = 1019371109;
      "Paprika Recipe Manager 3" = 1303222628;
      "Reeder 5" = 1529448980;
      "Things 3" = 904280696;
      Fantastical = 975937182;
    };
  };
}
