{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    choose
    comma
    difftastic
    dogdns
    du-dust
    duf
    exa
    fd
    grex
    htop
    mas
    manix
    mtr
    pv
    ripgrep
    sd
    tldr
  ];
}
