{ config, ... }: {
  sops.secrets = {
    opencode_anthropic_api_key = {
      sopsFile = ./secrets.json;
    };
  };

  programs.opencode.settings = {
    provider.anthropic = {
      options = {
        apiKey = "{file:${config.sops.secrets.opencode_anthropic_api_key.path}}";
      };
    };
  };
}
