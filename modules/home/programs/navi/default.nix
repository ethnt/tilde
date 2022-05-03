{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.navi;
  yamlFormat = pkgs.formats.yaml { };
  configDir = if pkgs.stdenv.isDarwin then
    "Library/Application Support"
  else
    config.xdg.configHome;
in {
  options.programs.navi = {
    enable = mkEnableOption "Enable Navi cheatsheets";
    package = mkOption {
      type = types.package;
      default = pkgs.navi;
    };
    enableFishIntegration = mkEnableOption "Enable Fish integration";
    settings = mkOption {
      inherit (yamlFormat) type;
      default = { };
    };
    # TODO: This currently just takes inline text -- maybe update to use the same type as `home.file`
    cheats = mkOption {
      type = types.attrsOf types.lines;
      default = { };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    programs.fish.shellInit = mkIf cfg.enableFishIntegration ''
      ${cfg.package}/bin/navi widget fish | source
    '';

    home.file = mkMerge [
      {
        "${configDir}/navi/config.yaml" = {
          source = yamlFormat.generate "navi-config" cfg.settings;
        };
      }
      (mapAttrs' (name: lines:
        nameValuePair "${configDir}/navi/cheats/${name}.cheat" {
          text = lines;
        }) cfg.cheats)
    ];
  };
}
