{ config, lib, pkgs, ... }:

with lib;

let cfg = config.programs.rippkgs;
in {
  options.programs.rippkgs = {
    enable = mkEnableOption "Enable rippkgs";

    package = mkOption {
      type = types.package;
      default = pkgs.rippkgs;
      description = "rippkgs package to install";
    };

    # indexerPackage = mkOption {
    #   type = types.package;
    #   default = pkgs.rippkgs-index;
    #   description = "rippkgs-index package to install";
    # };

    indexLocation = mkOption {
      type = types.str;
      default = "$XDG_DATA_HOME/rippkgs-index.sqlite";
      description = "Location of the rippkgs index";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with cfg;
      [
        package
        # indexerPackage
        #  indexerRunner
      ];
  };
}
