{ pkgs, lib, ... }: {
  programs.mcp.servers.honeycomb = {
    type = "stdio";
    command = lib.getExe pkgs.llm-agents.mcp-remote;
    args = [ "https://mcp.honeycomb.io/mcp" ];
  };
}
