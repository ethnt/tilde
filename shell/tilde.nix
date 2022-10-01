{ pkgs, ... }: {
  _file = toString ./.;

  devshell.startup.load_profiles = pkgs.lib.mkForce (pkgs.lib.noDepEntry ''
    _PATH=''${PATH}

    for file in "$DEVSHELL_DIR/etc/profile.d/"*.sh; do
      [[ -f "$file" ]] && source "$file"
    done

    export PATH=''${_PATH}
    unset _PATH
  '');

  commands = let addPackage = category: package: { inherit package category; };
  in [
    (addPackage "runtime" pkgs.nixUnstable)
    (addPackage "runtime" pkgs.cachix)

    (addPackage "development" pkgs.git-crypt)
    (addPackage "development" pkgs.dhall)

    (addPackage "code" pkgs.nixfmt)
    (addPackage "code" pkgs.statix)
    (addPackage "code" pkgs.haskellPackages.dhall-yaml)
  ];
}
