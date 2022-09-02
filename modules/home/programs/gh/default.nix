{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.gh;
  yamlFormat = pkgs.formats.yaml { };

  # TODO: Improve this typing
  hostsType = types.submodule { freeformType = yamlFormat.type; };
in {
  options.programs.gh = {
    defaultHost = mkOption {
      type = types.str;
      description = "The default host for <command>gh</command> actions";
      default = "github.com";
    };
    hosts = mkOption {
      type = hostsType;
      description = "Key-value of GitHub hosts for <command>gh</command>";
      default = { };
      example = literalExpression ''
        {
          "github.com" = {
            user = "foobar";
            git_protocol = "ssh";
            oauth_token = "ghp_..."
          };
        }
      '';
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile."gh/hosts.yml".source =
      yamlFormat.generate "gh-hosts.yml" cfg.hosts;

    home.sessionVariables.GH_HOST = cfg.defaultHost;
  };
}
