{ inputs, ... }: {
  imports = [ inputs.devenv.flakeModule ];

  perSystem = { config, pkgs, ... }: {
    devenv.shells.default = _:
      {
        env.FLAKE_ROOT = pkgs.lib.getExe config.flake-root.package;

        packages = with pkgs; [ cachix git-crypt dhall just statix ];
      } // {
        containers = pkgs.lib.mkForce { };
      };
  };
}
