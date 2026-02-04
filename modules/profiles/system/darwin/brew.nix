{ lib, ... }: {
  environment.systemPath = [ "/opt/homebrew/bin" ];

  homebrew = {
    enable = true;

    onActivation.cleanup = lib.mkDefault "zap";

    brews = [ "pinentry-mac" ];

    taps = [ "railwaycat/emacsmacport" ];

    casks = [
      "1password"
      "arc"
      "cleanshot"
      "dash"
      "docker-desktop"
      "elgato-stream-deck"
      "emacs-mac-spacemacs-icon"
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
    ];

    masApps = { "Amphetamine" = 937984704; };
  };
}
