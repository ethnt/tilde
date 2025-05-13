{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    comma
    difftastic
    eza
    fd
    fzy
    gnused
    graphite-cli
    htop
    jq
    just
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
  };
}
