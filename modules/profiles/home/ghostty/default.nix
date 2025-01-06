{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    package = pkgs.hello;

    enableFishIntegration = true;
    enableZshIntegration = true;

    installBatSyntax = false;
    installVimSyntax = false;

    settings = {
      font-family = "PragmataPro Mono Liga";
      font-size = 16;
      window-padding-x = 8;
      adjust-cell-height = 10;
      theme = "nord";
    };
  };
}
