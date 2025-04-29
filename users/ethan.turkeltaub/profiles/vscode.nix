{ pkgs, ... }: {
  programs.vscode.profiles.default = {
    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      name = "csdevkit";
      publisher = "ms-dotnettools";
      version = "1.19.35";
      sha256 = "chEfSSZcofWZGJcabfsfop5lnTD7aVqriBDvLCxsHWM=";
    }];
  };
}
