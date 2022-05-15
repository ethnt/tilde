{ config, ... }: {
  programs.micro = {
    enable = true;
    settings = {
      autosu = true;
      colorscheme = "solarized";
    };
    plugins = [ "autoclose" "comment" "ftoptions" "diff" ];
  };

  home.sessionVariables.EDITOR = "${config.programs.micro.package}/bin/micro";
}
