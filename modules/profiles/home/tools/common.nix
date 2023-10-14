{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    comma
    difftastic
    # exa
    fd
    gnused
    htop
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
