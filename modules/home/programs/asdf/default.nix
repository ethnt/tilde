{ config, lib, pkgs, ... }:

with lib;

let cfg = config.programs.asdf;
in {
  options.programs.asdf = {
    enable = mkEnableOption "Enable the asdf version manager";
    package = mkOption {
      description = "Which package to use for asdf-vm";
      type = types.package;
      default = pkgs.asdf-vm;
    };
    enableFishIntegration = mkOption {
      description = "Enable support inside of fish";
      type = types.bool;
      default = false;
    };
    extraConfig = mkOption {
      description = "Lines to be added to .asdfrc";
      type = types.lines;
      default = "";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.sessionVariables = {
      ASDF_DIR = cfg.package;
      ASDF_DATA_DIR = "${config.xdg.dataHome}/asdf";
      ASDF_CONFIG_FILE = "${config.xdg.configHome}/asdf/.asdfrc";
    };

    # Disable asdf from trying to update itself
    xdg.configFile."asdf/asdf_updates_disabled".text = "";

    # The adding of completions to fish don't work in the package, for some reason, so add them here
    programs.fish = mkIf cfg.enableFishIntegration {
      shellInit = mkAfter ''
        source ${cfg.package}/share/asdf-vm/asdf.fish
      '';

      interactiveShellInit = mkAfter ''
        set fish_complete_path $fish_complete_path ${cfg.package}/share/fish/vendor_completions.d
      '';
    };

    xdg.configFile."asdf/.asdfrc" = { text = cfg.extraConfig; };
  };
}
