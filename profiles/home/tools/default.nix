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
    gnused
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

  home.shellAliases = {
    # Alias `rg` to `rg -p`
    rg = "${pkgs.ripgrep}/bin/rg -p";

    # Alias `man` to `batman`
    man = "${pkgs.bat-extras.batman}/bin/batman";
  };
}
