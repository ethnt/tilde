{
  config,
  lib,
  pkgs,
  ...
}:
let
  grafana-mcp-wrapper = pkgs.writeShellScript "grafana-mcp-wrapper" ''
    export GRAFANA_URL="$(cat ${config.sops.secrets.grafana_mcp_url.path})"
    export GRAFANA_SERVICE_ACCOUNT_TOKEN="$(cat ${config.sops.secrets.grafana_mcp_service_account_token.path})"
    exec ${lib.getExe pkgs.mcp-grafana}
  '';
in
{
  sops.secrets = {
    grafana_mcp_url.sopsFile = ./secrets.json;
    grafana_mcp_service_account_token.sopsFile = ./secrets.json;
  };

  programs.mcp.servers.grafana = {
    command = toString grafana-mcp-wrapper;
  };
}
