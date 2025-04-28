{ self, ... }: {
  perSystem = { config, pkgs, lib, system, ... }: {
    devShells.default = pkgs.mkShell {
      inputsFrom = [ self.devShells.${system}.treefmt ];

      nativeBuildInputs = with pkgs; [ cachix just nix-output-monitor ];

      shellHook = ''
        export FLAKE_ROOT="${lib.getExe config.flake-root.package}"
      '';
    };
  };
}
