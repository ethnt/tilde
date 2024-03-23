{ inputs, ... }: {
  imports = [ inputs.devenv.flakeModule ];

  perSystem = { config, pkgs, lib, system, ... }: {
    devenv.shells.default = _:
      {
        env.FLAKE_ROOT = lib.getExe config.flake-root.package;

        packages = with pkgs; [
          inputs.devenv.packages.${system}.default
          cachix
          just
        ];
      } // {
        containers = lib.mkForce { };
      };
  };
}
