{ pkgs, lib, ... }: {
  programs.mcp.servers.honeycomb = {
    type = "stdio";
    command = lib.getExe pkgs.mcp-remote;
    args = [ "https://mcp.honeycomb.io/mcp" ];
  };
}
