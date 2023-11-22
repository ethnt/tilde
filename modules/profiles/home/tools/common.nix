{ pkgs, ... }: {
  home.packages = with pkgs; [
    # exa
    comma
    difftastic
    fd
    gnused
    htop
    just
    nix-index
    ripgrep
  ];

  home.shellAliases = {
    # Alias `rg` to `rg -p`
    rg = "${pkgs.ripgrep}/bin/rg -p";

    # Alias `man` to `batman`
    man = "${pkgs.bat-extras.batman}/bin/batman";
  };
}
