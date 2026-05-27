{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    fira
    ia-writer-duospace
    ia-writer-mono
    ia-writer-quattro
    ibm-plex
    powerline-fonts
    pragmatapro
    sf-pro
  ];
}
