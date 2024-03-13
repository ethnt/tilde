{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    comma
    difftastic
    eza
    fd
    gnused
    htop
    just
    nix-index
    ripgrep
  ];

  home.shellAliases = {
    # Alias `rg` to `rg -p`
    rg = "${lib.getExe pkgs.ripgrep} -p";

    # Alias `man` to `batman`
    man = lib.getExe' pkgs.bat-extras.batman "batman";
  };
}
