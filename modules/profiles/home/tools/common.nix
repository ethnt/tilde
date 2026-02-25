{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    comma
    curl
    curlie
    doggo
    fd
    gnused
    htop
    httpie
    jq
    just
    mtr
    nh
    nixd
    nix-index
    nix-output-monitor
    pgcli
    ripgrep
    tldr
  ];

  home.shellAliases = {
    # Alias `rg` to `rg -p`
    rg = "${lib.getExe pkgs.ripgrep} -p";

    # Alias `man` to `batman`
    man = lib.getExe' pkgs.bat-extras.batman "batman";
  };
}
