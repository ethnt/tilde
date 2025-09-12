{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.navi;
  configDir = if pkgs.stdenv.isDarwin then
    "Library/Application Support"
  else
    config.xdg.configHome;
  printTags = tags: "% ${concatStringsSep ", " tags}";
  printCheats = cheats:
    concatStringsSep "\n" (map (cheat: ''
      # ${cheat.description}
      ${cheat.command}
    '') cheats);
  printVariables = variables:
    concatStringsSep "\n" (mapAttrsToList (name: value: ''
      $ ${name}: ${value}
    '') variables);
  printExtensions = extensions: "@ ${concatStringsSep ", " extensions}";
in {
  options.programs.navi = {
    cheatfiles = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          tags = mkOption {
            type = types.listOf types.str;
            description = "Tags for this cheatfile";
          };
          cheats = mkOption {
            type = types.listOf (types.submodule {
              options = {
                description = mkOption {
                  type = types.str;
                  description = "Description of this cheat";
                };
                command = mkOption {
                  type = types.lines;
                  description = "What to run for this cheat";
                };
              };
            });
            default = [ ];
          };
          variables = mkOption {
            type = types.attrs;
            default = { };
            description = "Variables for this cheatfile";
          };
          extensions = mkOption {
            type = types.listOf types.str;
            default = [ ];
            description = "Other cheatfiles to extend into this file";
          };
        };
      });
    };
  };

  config = mkIf cfg.enable {
    home.file = mapAttrs' (name: cheatfile:
      nameValuePair "${configDir}/navi/cheats/${name}.cheat" {
        text = ''
          ${printTags cheatfile.tags}
          ${printCheats cheatfile.cheats}
          ${printVariables cheatfile.variables}
          ${printExtensions cheatfile.extensions}
        '';
      }) cfg.cheatfiles;
  };
}
