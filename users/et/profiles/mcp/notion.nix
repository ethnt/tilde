{ pkgs, lib, ... }: {
  programs.mcp.servers.notion = {
    type = "stdio";
    command = lib.getExe pkgs.llm-agents.mcp-remote;
    args = [ "https://mcp.notion.com/mcp" ];
  };
}
