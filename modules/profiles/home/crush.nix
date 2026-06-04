{ config, ... }: {
  programs.crush = {
    enable = true;
    settings.mcp = config.programs.mcp.servers;
  };

  home.file.".config/crush/crush.json".force = true;
}
