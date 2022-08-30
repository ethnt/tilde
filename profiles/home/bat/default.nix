{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    config.theme = "Solarized (dark)";
  };

  home.packages = with pkgs.bat-extras; [ batdiff batgrep batman ];
}
