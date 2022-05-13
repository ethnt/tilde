{ config, ... }: {
  programs.micro = {
    enable = true;
    settings = {
      autosu = true;
      colorscheme = "solarized";
    };
    extraPlugins = [ "filemanager" ];
  };

  home.sessionVariables.EDITOR = "${config.programs.micro.package}/bin/micro";
}
