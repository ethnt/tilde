{ pkgs, lib, ... }: {
  programs.mcp.servers.notion = {
    type = "stdio";
    command = lib.getExe pkgs.mcp-remote;
    args = [ "https://mcp.notion.com/mcp" ];
  };
}
