{ pkgs, lib, ... }:
let
  mcp-remote = pkgs.writeShellScriptBin "mcp-remote" ''
    exec ${lib.getExe pkgs.nodejs "npx"} -y mcp-remote@latest "$@"
  '';
in {
  programs.mcp.servers.linear = {
    type = "stdio";
    command = "${mcp-remote}/bin/mcp-remote";
    args = [ "https://mcp.linear.app/mcp" ];
  };
}
