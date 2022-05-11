{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.tmuxp;
  yamlFormat = pkgs.formats.yaml { };
in {
  options.programs.tmuxp = {
    enable = mkEnableOption "Enable tmuxp";
    package = mkOption {
      type = types.package;
      default = pkgs.tmuxp;
    };
    workspaces = mkOption {
      type = types.attrsOf yamlFormat.type;
      default = { };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file = mapAttrs' (name: attrs:
      nameValuePair ".tmuxp/${name}.yaml" {
        source = yamlFormat.generate "tmuxp-${name}.yaml" attrs;
      }) cfg.workspaces;
  };
}
