{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    comma
    curl
    curlie
    dogdns
    fd
    gnused
    graphite-cli
    htop
    httpie
    jq
    just
    mtr
    nh
    nix-index
    nix-output-monitor
    ripgrep
    tldr
  ];

  home.shellAliases = {
    # Alias `rg` to `rg -p`
    rg = "${lib.getExe pkgs.ripgrep} -p";

    # Alias `man` to `batman`
    man = lib.getExe' pkgs.bat-extras.batman "batman";

    # Alias `ctop` to use correct `$TERM`
    ctop = ''TERM="(string-replace tmux screen $TERM)" ${lib.getExe pkgs.ctop}'';
  };
}
