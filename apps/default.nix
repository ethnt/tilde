{ self, pkgs }: {
  build = self.inputs.flake-utils.lib.mkApp {
    drv = pkgs.writeShellScriptBin "build" ''
      darwin-rebuild build --flake .#
    '';
  };

  switch = self.inputs.flake-utils.lib.mkApp {
    drv = pkgs.writeShellScriptBin "switch" ''
      darwin-rebuild switch --flake .#
    '';
  };

  format = self.inputs.flake-utils.lib.mkApp {
    drv = pkgs.writeShellScriptBin "format" ''
      ${pkgs.nixfmt}/bin/nixfmt **/*.nix
      ${pkgs.dhall}/bin/dhall format **/*.dhall
    '';
  };

  lint = self.inputs.flake-utils.lib.mkApp {
    drv = pkgs.writeShellScriptBin "lint" ''
      ${pkgs.statix}/bin/statix check ${self}
    '';
  };

  generate-ci = self.inputs.flake-utils.lib.mkApp {
    drv = pkgs.writeShellScriptBin "generate-ci" ''
      ${pkgs.dhall-json}/bin/dhall-to-yaml --file config/ci.dhall --output .github/workflows/ci.yml
    '';
  };
}
