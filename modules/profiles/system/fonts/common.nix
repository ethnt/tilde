{ pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ fira ibm-plex powerline-fonts sf-pro ];
  };
}
