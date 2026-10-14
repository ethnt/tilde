{ pkgs, lib, ... }: {
  programs.mcp.servers.linear = {
    type = "stdio";
    command = lib.getExe pkgs.llm-agents.mcp-remote;
    args = [ "https://mcp.linear.app/mcp" ];
  };
}
