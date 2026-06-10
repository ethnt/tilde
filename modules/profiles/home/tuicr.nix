{ pkgs, ... }: {
  home.packages = [ pkgs.llm-agents.tuicr ];

  xdg.configFile."tuicr/config.toml".text = ''
    theme = "nord-dark"
    mouse = true
  '';
}
