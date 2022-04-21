{ pkgs, ... }: {
  home.packages = with pkgs; [
    choose
    difftastic
    dogdns
    du-dust
    duf
    exa
    fd
    glances
    htop
    mtr
    mtr
    ripgrep
    sd
    tldr
    pv
  ];
}
