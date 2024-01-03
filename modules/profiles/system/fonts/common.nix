{ inputs, pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      fira
      ibm-plex
      powerline-fonts
      sf-pro
      inputs.pragmatapro.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
