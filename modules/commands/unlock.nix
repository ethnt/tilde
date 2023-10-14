{
  perSystem = { pkgs, ... }: {
    apps = {
      unlock.program = pkgs.writeShellScriptBin "unlock" ''
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
  };
}
