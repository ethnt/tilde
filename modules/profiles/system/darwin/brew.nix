{ lib, ... }: {
  environment.systemPath = [ "/opt/homebrew/bin" ];

  homebrew = {
    enable = true;

    onActivation.cleanup = lib.mkDefault "zap";

    brews = [ "pinentry-mac" ];

    taps = [
      {
        name = "railwaycat/emacsmacport";
        trusted = true;
      }
    ];

    casks = [
      "1password"
      "arc"
      "cleanshot"
      "emacs-mac-spacemacs-icon"
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
      "zen"
    ];

    masApps = {
      "Amphetamine" = 937984704;
    };
  };
}
