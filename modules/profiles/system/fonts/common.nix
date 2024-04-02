{ inputs, pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      fira
      ibm-plex
      powerline-fonts
      pragmatapro
      sf-pro
    ];
  };
}
