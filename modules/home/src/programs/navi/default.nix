{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.navi;
  configDir = if pkgs.stdenv.isDarwin then
    "Library/Application Support"
  else
    config.xdg.configHome;
in {
  options.programs.navi = {
    # TODO: This currently just takes inline text -- maybe update to use the same type as `home.file`
    cheats = mkOption {
      type = types.attrsOf types.lines;
      default = { };
    };
  };

  config = mkIf cfg.enable {
    home.file = mapAttrs' (name: lines:
      nameValuePair "${configDir}/navi/cheats/${name}.cheat" { text = lines; })
      cfg.cheats;
  };
}
