{
  perSystem = { pkgs, ... }: {
    apps = {
      build.program = pkgs.writeShellScriptBin "build" ''
        darwin-rebuild build --flake .#
      '';
    };
  };
}
