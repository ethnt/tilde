{ inputs, ... }: {
  imports = [ inputs.devenv.flakeModule ];

  perSystem = { config, pkgs, lib, ... }: {
    devenv.shells.default = _:
      {
        env.FLAKE_ROOT = lib.getExe config.flake-root.package;

        packages = with pkgs; [ cachix git-crypt dhall just statix ];
      } // {
        containers = lib.mkForce { };
      };
  };
}
