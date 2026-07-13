{
  config,
  lib,
  pkgs,
  ...
}:
{
  sops.secrets = {
    postgres_mcp_connection_string_production.sopsFile = ./secrets.json;
    postgres_mcp_connection_string_development.sopsFile = ./secrets.json;
  };

  programs.mcp.servers = {
    postgres-production = {
      command = lib.getExe pkgs.postgres-mcp;
      env = {
        DATABASE_URI = "$(cat ${config.sops.secrets.postgres_mcp_connection_string_production.path}})";
      };
    };
    postgres-development = {
      command = lib.getExe pkgs.postgres-mcp;
      env = {
        DATABASE_URI = "$(cat ${config.sops.secrets.postgres_mcp_connection_string_development.path}})";
      };
    };
  };
}
