{ pkgs, ... }:
let
  emacs = pkgs.emacs29-macport.override {
    withNativeCompilation = true;
    withSQLite3 = true;
  };
  emacsWithPackages = (pkgs.emacsPackagesFor emacs).emacsWithPackages (epkgs:
    with epkgs; [
      deadgrep
      which-key
      vterm
      multi-vterm
      modus-themes
      org-modern
    ]);
in {
  programs.emacs = {
    enable = true;
    package = emacsWithPackages;
    extraConfig = builtins.readFile ./config.el;
  };

  home.packages = with pkgs; [ emacs-all-the-icons-fonts ];
}
