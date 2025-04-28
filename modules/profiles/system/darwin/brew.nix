{ lib, ... }: {
  environment.systemPath = [ "/opt/homebrew/bin" ];

  homebrew = {
    enable = true;

    onActivation.cleanup = lib.mkDefault "zap";

    casks = [
      "1password"
      "bartender"
      "dash"
      "firefox"
      "iterm2"
      "jabra-direct"
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
