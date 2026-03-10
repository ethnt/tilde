{ inputs, ... }: {
  imports = [ inputs.treefmt.flakeModule ];

  perSystem = { config, pkgs, ... }:
    let
      treefmtConfig = {
        inherit (config.flake-root) projectRootFile;

        programs = {
          actionlint.enable = true;
          deadnix.enable = true;
          statix.enable = true;
          nixfmt = {
            enable = true;
            package = pkgs.nixfmt-classic;
          };
          prettier.enable = true;
        };
      };
    in {
      treefmt.config = treefmtConfig;

      formatter = inputs.treefmt.lib.mkWrapper pkgs treefmtConfig;

      devShells.treefmt = pkgs.mkShell {
        nativeBuildInputs = [ config.treefmt.build.wrapper ]
          ++ (builtins.attrValues config.treefmt.build.programs);
      };
    };
}
