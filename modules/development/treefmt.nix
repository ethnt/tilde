{ inputs, ... }: {
  imports = [ inputs.treefmt.flakeModule ];

  perSystem =
    { config, pkgs, ... }:
    let
      treefmtConfig = {
        inherit (config.flake-root) projectRootFile;

        programs = {
          actionlint.enable = true;
          deadnix.enable = true;
          statix.enable = true;
          nixfmt.enable = true;
          prettier.enable = true;
        };
        settings.formatter = {
          prettier.excludes = [
            ".github/**/*.yml"
            "secrets.json"
            "**/secrets.json"
            "**/secrets.yml"
          ];
        };
      };
    in
    {
      treefmt.config = treefmtConfig;

      formatter = inputs.treefmt.lib.mkWrapper pkgs treefmtConfig;

      devShells.treefmt = pkgs.mkShell {
        nativeBuildInputs = [
          config.treefmt.build.wrapper
        ]
        ++ (builtins.attrValues config.treefmt.build.programs);
      };
    };
}
