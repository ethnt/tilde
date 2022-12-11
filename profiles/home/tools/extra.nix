{ pkgs, config, ... }: {
  home.packages = with pkgs; [ choose grex manix mtr pv sd tldr ];

  home.shellAliases = {
    # Alias `rg` to `rg -p`
    rg = "${pkgs.ripgrep}/bin/rg -p";

    # Alias `man` to `batman`
    man = "${pkgs.bat-extras.batman}/bin/batman";
  };
}
