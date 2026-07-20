{ config, pkgs, ... }: {
  sops.secrets = {
    opencode_api_key = {
      sopsFile = ./secrets.json;
    };
  };

  programs.opencode = {
    enable = true;
    package = pkgs.llm-agents.opencode;
    enableMcpIntegration = true;
    tui = {
      theme = "nord";
    };
    settings = {
      formatter = true;
      lsp = true;
      provider = {
        opencode = {
          options = {
            apiKey = "{file:${config.sops.secrets.opencode_api_key.path}}";
          };
        };
      };
      permission = {
        "*" = "ask";
      };
    };
  };
}
