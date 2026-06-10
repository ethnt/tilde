{ config, ... }: {
  sops.secrets = {
    opencode_anthropic_api_key = {
      sopsFile = ./secrets.json;
      path =
        "${config.xdg.dataHome}/secrets/opencode/opencode-anthropic-api-key";
    };
  };

  programs.opencode.settings = {
    provider.anthropic = {
      options = {
        apiKey =
          "{file:${config.sops.secrets.opencode_anthropic_api_key.path}}";
      };
    };
  };
}
