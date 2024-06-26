{ inputs, ... }: {
  imports = [ inputs.treefmt.flakeModule ];

  perSystem = { config, pkgs, ... }:
    let
      settings = {
        inherit (config.flake-root) projectRootFile;
        programs = {
          deadnix.enable = true;
          nixfmt.enable = true;
          statix.enable = true;
          prettier.enable = true;
        };
      };
    in {
      treefmt.config = settings;

      formatter = inputs.treefmt.lib.mkWrapper pkgs settings;

      devenv.shells.default.packages = with pkgs;
        [ config.treefmt.build.wrapper ]
        ++ (builtins.attrValues config.treefmt.build.programs);
    };
}
