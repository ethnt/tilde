{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    comma
    difftastic
    exa
    fd
    gnused
    htop
    nix-index
  ];

  home.shellAliases = {
    # Alias `man` to `batman`
    man = "${pkgs.bat-extras.batman}/bin/batman";
  };
}
