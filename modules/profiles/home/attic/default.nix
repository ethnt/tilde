{ inputs, pkgs, ... }: {
  home.packages = [ inputs.attic.packages.${pkgs.system}.attic ];
}
