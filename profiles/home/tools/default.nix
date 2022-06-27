{ pkgs, ... }: {
  home.packages = with pkgs; [
    comma
    choose
    difftastic
    dogdns
    du-dust
    duf
    exa
    fd
    htop
    mtr
    mtr
    ripgrep
    sd
    tldr
    pv
  ];
}
