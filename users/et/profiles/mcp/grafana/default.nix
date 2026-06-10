{ config, lib, pkgs, ... }: {
  sops.secrets = {
    grafana_mcp_url.sopsFile = ./secrets.json;
    grafana_mcp_service_account_token.sopsFile = ./secrets.json;
  };

  programs.mcp.servers.grafana = {
    command = lib.getExe pkgs.mcp-grafana;
    env = {
      GRAFANA_URL = "$(cat ${config.sops.secrets.grafana_mcp_url.path}})";
      GRAFANA_SERVICE_ACCOUNT_TOKEN =
        "$(cat ${config.sops.secrets.grafana_mcp_service_account_token.path}})";
    };
  };
}
