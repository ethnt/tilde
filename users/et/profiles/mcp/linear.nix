{ pkgs, lib, ... }: {
  programs.mcp.servers.linear = {
    type = "stdio";
    command = lib.getExe pkgs.mcp-remote;
    args = [ "https://mcp.linear.app/mcp" ];
  };
}
