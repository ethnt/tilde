{ config, ... }: {
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

  mcp-servers.programs.github = {
    enable = true;
    envFile = config.sops.templates.github_mcp_env_file.path;
  };
}
