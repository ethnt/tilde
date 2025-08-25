{ self, inputs, ... }: {
  perSystem = { config, pkgs, lib, system, ... }: {
    devShells.default = pkgs.mkShell {
      inputsFrom = [ self.devShells.${system}.treefmt ];

      nativeBuildInputs = with pkgs; [
        cachix
        just
        nh
        nix-output-monitor
        inputs.home-manager.packages.${system}.default
      ];

      shellHook = ''
        export FLAKE_ROOT="${lib.getExe config.flake-root.package}"
      '';
    };
  };
}
