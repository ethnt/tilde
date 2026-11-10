{
  config,
  lib,
  pkgs,
  ...
}:
let
  postgres-mcp-wrapper =
    database-uri-path:
    pkgs.writeShellScript "postgres-mcp-wrapper" ''
      export DATABASE_URI="$(cat ${database-uri-path})"
      exec ${lib.getExe pkgs.postgres-mcp}
    '';
in
{
  sops.secrets = {
    postgres_mcp_connection_string_production.sopsFile = ./secrets.json;
    postgres_mcp_connection_string_development.sopsFile = ./secrets.json;
  };

  programs.mcp.servers = {
    postgres-production = {
      command = toString (
        postgres-mcp-wrapper config.sops.secrets.postgres_mcp_connection_string_production.path
      );
    };
    postgres-development = {
      command = toString (
        postgres-mcp-wrapper config.sops.secrets.postgres_mcp_connection_string_development.path
      );
    };
  };
}
