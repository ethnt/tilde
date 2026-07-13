{ config, pkgs, ... }:

let
  github-mcp-wrapper = pkgs.writeShellScript "github-mcp-wrapper" ''
    export GITHUB_PERSONAL_ACCESS_TOKEN="$(cat ${config.sops.secrets.github_mcp_pat.path})"
    exec ${pkgs.github-mcp-server}/bin/github-mcp-server stdio
  '';
in
{
  sops = {
    secrets.github_mcp_pat = {
      sopsFile = ./secrets.json;
      path = "${config.xdg.dataHome}/secrets/mcp/github-mcp-pat.txt";
    };

    templates.github_mcp_env_file = {
      content = ''
        GITHUB_PERSONAL_ACCESS_TOKEN=${config.sops.placeholder.github_mcp_pat}
      '';
      mode = "0777";
    };
  };

  programs.mcp.servers.github = {
    command = toString github-mcp-wrapper;
    args = [ ];
  };
}
