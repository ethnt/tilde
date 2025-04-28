{ pkgs, ... }: {
  programs.vscode.profiles.default = {
    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "ruby-extensions-pack";
        publisher = "Shopify";
        version = "0.1.13";
        sha256 = "6MPtFxK3p5ZhX2FKXpT3Fk6m35h9u7xwsmHEg87qAxM=";
      }
      {
        name = "ruby-lsp";
        publisher = "Shopify";
        version = "0.9.16";
        sha256 = "X+Ym36NWQOYXW5IcevImdkKU1IAr36YGZrNziacIHWA=";
      }
    ];
    userSettings = {
      "[astro]" = { "editor.defaultFormatter" = "astro-build.astro-vscode"; };
    };
  };
}
