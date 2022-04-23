{ pkgs, ... }: {
  programs.asdf = {
    enable = true;
    package = pkgs.asdf-vm;
    enableFishIntegration = true;
    extraConfig = ''
      legacy_version_file = yes
    '';
  };
}
