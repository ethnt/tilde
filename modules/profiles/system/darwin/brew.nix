{ lib, ... }: {
  environment.systemPath = [ "/opt/homebrew/bin" ];

  homebrew = {
    enable = true;

    onActivation.cleanup = lib.mkDefault "zap";

    casks = [
      "1password"
      "cursor"
      "dash"
      "firefox"
      "iterm2"
      "jabra-direct"
      "jordanbaird-ice"
      "logitune"
      "monitorcontrol"
      "raycast"
      "rectangle"
      "slack"
      "spotify"
      "zed"
    ];
  };
}
