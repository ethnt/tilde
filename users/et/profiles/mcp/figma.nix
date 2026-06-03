{ pkgs, lib, ... }: {
  programs.mcp.servers.figma = {
    type = "stdio";
    command = lib.getExe pkgs.mcp-remote;
    args = [ "https://mcp.figma.com/mcp" ];
  };
}
