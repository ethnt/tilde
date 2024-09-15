{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    fira
    ibm-plex
    powerline-fonts
    pragmatapro
    sf-pro
  ];
}
