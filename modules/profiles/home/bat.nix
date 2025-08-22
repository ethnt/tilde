{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    config.theme = "Nord";
  };

  home.packages = with pkgs.bat-extras; [ batdiff batgrep batman ];
}
