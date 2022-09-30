{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    choose
    comma
    difftastic
    dogdns
    du-dust
    duf
    dug
    exa
    fd
    grex
    htop
    mas
    manix
    mtr
    nix-index
    pv
    ripgrep
    sd
    tldr
  ];
}
