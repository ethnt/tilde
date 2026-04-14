{ lib, pkgs, ... }: {
  programs.mcp.servers.nixos = {
    command = lib.getExe pkgs.mcp-nixos;
    args = [ ];
  };
}
