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
      {
        name = "abue-ammar/tinycast";
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
      "logitune"
      "monitorcontrol"
      "notion"
      "obsidian"
      "rectangle"
      "slack"
      "spotify"
      "thaw@beta"
      "tinycast"
      "zen"
    ];

    masApps = {
      "Amphetamine" = 937984704;
    };
  };
}
