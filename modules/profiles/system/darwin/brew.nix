{ lib, ... }: {
  environment.systemPath = [ "/opt/homebrew/bin" ];

  homebrew = {
    enable = true;

    onActivation.cleanup = lib.mkDefault "zap";

    casks = [
      "1password"
      "bartender"
      "firefox"
      "iterm2"
      "logitech-options"
      "raycast"
      "rectangle"
      "spotify"
    ];
  };
}
