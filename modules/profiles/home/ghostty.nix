{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    package = pkgs.ghostty-bin;
    settings = {
      adjust-cell-height = 10;
      cursor-style = "bar";
      font-family = "PragmataPro Mono Liga";
      font-size = 16;
      theme = "nord";
      window-padding-x = 8;
    };
  };
}
