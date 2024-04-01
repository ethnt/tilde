# { pkgs, ... }: { home.packages = with pkgs; [ rippkgs rippkgs-index ]; }
{
  programs.rippkgs.enable = true;
}
