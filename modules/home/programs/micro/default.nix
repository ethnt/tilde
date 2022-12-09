{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.micro;
  plugins = genAttrs cfg.plugins (name: true);
  settings = cfg.settings // plugins;
  colorschemes = mapAttrs' (name: configuration:
    nameValuePair "micro/colorschemes/${name}.micro" {
      text = concatStringsSep "" (mapAttrsToList (variable: value: ''
        color-link ${variable} "${value}"
      '') configuration);
    }) cfg.colorschemes;
in {
  options.programs.micro = {
    enable = mkEnableOption "Enable micro";
    package = mkOption {
      type = types.package;
      default = pkgs.micro;
    };
    settings = mkOption {
      type = types.attrs;
      default = { };
    };
    bindings = mkOption {
      description = "Rebind keys and key combinations to certain actions";
      type = types.attrsOf types.str;
      default = {
        "Alt-/" = "lua:comment.comment";
        "CtrlUnderscore" = "lua:comment.comment";
      };
      example = {
        "Alt-/" = "lua:comment.comment";
        "CtrlUnderscore" = "lua:comment.comment";
      };
    };
    colorschemes = mkOption {
      type = types.attrsOf (types.attrsOf types.str);
      default = { };
    };
    plugins = mkOption {
      description = "Any built-in plugins to enable";
      type = types.listOf types.str;
      default = [ ];
    };
    extraPlugins = mkOption {
      description = "Any additional plugins to install via the plugin manager";
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile = {
      "micro/settings.json".text = builtins.toJSON settings;
      "micro/bindings.json".text = builtins.toJSON cfg.bindings;
    } // colorschemes;

    home.activation.installMicroPlugins = ''
      ${concatStringsSep "\n"
      (map (name: "${pkgs.micro}/bin/micro -plugin install ${name}")
        cfg.extraPlugins)}
    '';
  };
}
