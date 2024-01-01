{ pkgs, ... }: {
  home.packages = with pkgs; [ choose dogdns grex manix mtr pv sd tldr ];
}
