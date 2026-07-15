{
  config,
  lib,
  pkgs,
  ...
}:
{
  sops.secrets = {
    firehydrant_mcp_api_key.sopsFile = ./secrets.json;
  };

  programs.mcp.servers.firehydrant = {
    command = lib.getExe pkgs.firehydrant-mcp;
    args = [
      "start"
      "--api-key=$(cat ${config.sops.secrets.firehydrant_mcp_api_key.path})"
    ];
  };
}
