{ pkgs, ... }: {
  home.packages = with pkgs; [ nodejs_25 pnpm ];

  home.sessionPath = [ "$HOME/.pnpm" ];
}
