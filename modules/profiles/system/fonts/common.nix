{ pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ ibm-plex fira sf-pro ];
  };
}
