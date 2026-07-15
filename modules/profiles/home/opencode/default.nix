{ config, pkgs, ... }: {
  sops.secrets = {
    opencode_api_key = {
      sopsFile = ./secrets.json;
      path = "${config.xdg.dataHome}/secrets/opencode/opencode-api-key";
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
