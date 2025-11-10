{ pkgs, ... }: {
  home.packages = with pkgs; [ claude-code graphite-cli fnm mkcert ];

  programs.fish.interactiveShellInit = let fnm = pkgs.lib.getExe pkgs.fnm;
  in ''
    ${fnm} env --use-on-cd --shell fish | source
  '';
}
