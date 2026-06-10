{ pkgs, lib, ... }: {
  programs.mcp.servers.sentry = {
    type = "stdio";
    command = lib.getExe pkgs.mcp-remote;
    args = [ "https://mcp.sentry.dev/mcp" ];
  };
}
