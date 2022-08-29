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

    (addPackage "formatting" pkgs.nixfmt)
  ];
}
