{ pkgs, ... }: {
  home.packages = with pkgs; [ dogdns choose grex manix mtr pv sd tldr ];
}
