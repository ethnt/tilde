{
  config,
  lib,
  pkgs,
  ...
}:
let
  transcend-consent-mcp-wrapper = pkgs.writeShellScript "transcend-consent-mcp-wrapper" ''
    export TRANSCEND_API_KEY="$(cat ${config.sops.secrets.transcend_consent_mcp_api_key.path})"
    exec ${lib.getExe pkgs.transcend-consent-mcp}
  '';
in
{
  sops.secrets = {
    transcend_consent_mcp_api_key.sopsFile = ./secrets.json;
  };

  programs.mcp.servers.transcend-consent = {
    command = toString transcend-consent-mcp-wrapper;
    env = {
      TRANSCEND_API_URL = "https://api.us.transcend.io";
    };
  };
}
