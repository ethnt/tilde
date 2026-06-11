{ lib, ... }: {
  environment.systemPath = [ "/opt/homebrew/bin" ];

  homebrew = {
    enable = true;

    onActivation = {
      cleanup = lib.mkDefault "zap";

      # TODO: Remove when this issue is fixed
      # https://github.com/nix-darwin/nix-darwin/pull/1789
      extraFlags = [ "--force-cleanup" ];
    };

    brews = [ "pinentry-mac" ];

    taps = [ "railwaycat/emacsmacport" ];

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
    ];

    masApps = { "Amphetamine" = 937984704; };
  };
}
