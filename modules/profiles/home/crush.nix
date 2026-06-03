{ config, ... }: {
  programs.crush = {
    enable = true;
    settings.mcp = config.programs.mcp.servers;
  };
}
