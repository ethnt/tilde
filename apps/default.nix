{ self, pkgs, }: {
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

  unlock = self.inputs.flake-utils.lib.mkApp {
    drv = pkgs.writeShellScriptBin "unlock" ''
      GIT_CRYPT_KEY=/tmp/git-crypt-key

      if [ -z "''${1}" ]; then
        echo "Requires an argument of a file or base64-encoded string"
        exit 1;
      fi

      if [ -f "''${1}" ]; then
        cat "''${1}" | base64 -d > $GIT_CRYPT_KEY
      else
        echo "''${1}" | base64 -d > $GIT_CRYPT_KEY
      fi

      ${pkgs.git-crypt}/bin/git-crypt unlock $GIT_CRYPT_KEY

      rm $GIT_CRYPT_KEY
    '';
  };

  repl = self.inputs.flake-utils.lib.mkApp {
    drv = pkgs.writeShellScriptBin "repl" ''
      if [ -z "$1" ]; then
        nix repl --argstr host "$(hostname)" --argstr flakePath "${self}" ${
          ./repl.nix
        }
      else
        nix repl --argstr host "$(hostname)" --argstr flakePath $(readlink -f $1 | sed 's|/flake.nix||') ${
          ./repl.nix
        }
      fi
    '';
  };

  generate-ci = self.inputs.flake-utils.lib.mkApp {
    drv = pkgs.writeShellScriptBin "generate-ci" ''
      ${pkgs.dhall-json}/bin/dhall-to-yaml \
        --file config/ci.dhall \
        --output .github/workflows/ci.yml
    '';
  };

  test-format = self.inputs.flake-utils.lib.mkApp {
    drv = pkgs.writeShellScriptBin "test-format" ''
      ${pkgs.nixfmt}/bin/nixfmt --check **/*.nix
      ${pkgs.dhall}/bin/dhall format --check **/*.dhall
    '';
  };

  test-lint = self.inputs.flake-utils.lib.mkApp {
    drv = pkgs.writeShellScriptBin "test-lint" ''
      ${pkgs.statix}/bin/statix check .
    '';
  };
}
