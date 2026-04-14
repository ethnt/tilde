{ lib, pkgs, ... }: {
  programs.mcp.servers.context7 = {
    command = lib.getExe pkgs.context7-mcp;
    args = [ ];
  };
}
