{ lib, ... }: {
  environment.systemPath = [ "/opt/homebrew/bin" ];

  homebrew = {
    enable = true;

    onActivation.cleanup = lib.mkDefault "none";

    brews = [ "pinentry-mac" ];

    casks = [
      "1password"
      "arc"
      "bartender"
      "cleanshot"
      "dash"
      "docker"
      "ghostty"
      "fantastical"
      "firefox"
      "istat-menus"
      "iterm2"
      "jabra-direct"
      "logitune"
      "monitorcontrol"
      "obsidian"
      "raycast"
      "rectangle"
      "slack"
      "spotify"
      "zoom"
    ];

    masApps = { "Amphetamine" = 937984704; };
  };
}
