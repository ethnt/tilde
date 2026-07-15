{ pkgs, ... }: {
  home.packages = with pkgs; [
    nodejs
    pnpm
  ];

  home.sessionPath = [ "$HOME/.pnpm" ];
}
