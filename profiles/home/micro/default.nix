{ config, ... }: {
  programs.micro = {
    enable = true;
    settings = {
      autosu = true;
      colorscheme = "solarized";
    };
    plugins = [ "autoclose" "comment" "ftoptions" "diff" ];
  };
}
