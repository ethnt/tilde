{ inputs, ... }: {
  imports = [ inputs.devenv.flakeModule ];

  perSystem = { config, pkgs, lib, system, ... }: {
    devenv.shells.default = _:
      {
        env = {
          FLAKE_ROOT = lib.getExe config.flake-root.package;
          TILDE_SYS_DRV = "/nix/var/nix/profiles/system";
        };

        packages = with pkgs; [
          inputs.home-manager.packages.${system}.default
          cachix
          just
          statix
        ];
      } // {
        containers = lib.mkForce { };
      };
  };
}
