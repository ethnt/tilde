{ lib, ... }: {
  environment.systemPath = [ "/opt/homebrew/bin" ];

  homebrew = {
    enable = true;

    onActivation.cleanup = lib.mkDefault "zap";

    brews = [ "pinentry-mac" ];

    casks = [
      "1password"
      "arc"
      "cleanshot"
      "dash"
      "elgato-stream-deck"
      "ghostty"
      "fantastical"
      "firefox"
      "istat-menus"
      "iterm2"
      "jordanbaird-ice"
      "logitune"
      "monitorcontrol"
      "notion"
      "obsidian"
      "raycast"
      "rectangle"
      "slack"
      "spotify"
      "zen-browser"
    ];

    masApps = { "Amphetamine" = 937984704; };
  };
}
