{ pkgs, config,... }: {
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
    manix
    mtr
    pv
    ripgrep
    sd
    tldr
    # tilde
    # (pkgs.writeScriptBin "tilde"
    #   (builtins.readFile "${config.tilde.directory}/packages/tilde/tilde"))
  ];
}
