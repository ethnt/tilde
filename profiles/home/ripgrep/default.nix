{ pkgs, ... }: {
  home.packages = with pkgs; [ ripgrep ];

  home.shellAliases = {
    # Alias `rg` to `rg -p`
    rg = "${pkgs.ripgrep}/bin/rg -p";
  };
}
