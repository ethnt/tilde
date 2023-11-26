{ pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ fira ibm-plex pragmatapro powerline-fonts sf-pro ];
  };
}
