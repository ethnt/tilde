{
  perSystem = { pkgs, ... }: {
    apps = {
      switch.program = pkgs.writeShellScriptBin "switch" ''
        darwin-rebuild switch --flake .#
      '';
    };
  };
}
