{ pkgs, ... }: {
  programs.vscode.profiles.default = {
    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "haskell";
        publisher = "haskell";
        version = "2.6.1";
        sha256 = "44pQBHz8e1dCqZaa5+GhPr0/SUsHlaqdNMPZklKdY+Q=";
      }
      {
        name = "language-haskell";
        publisher = "justusadam";
        version = "3.6.0";
        sha256 = "rZXRzPmu7IYmyRWANtpJp3wp0r/RwB7eGHEJa7hBvoQ=";
      }
      {
        name = "starlark";
        publisher = "didericis";
        version = "1.0.0";
        sha256 = "mFPxUmt5HGVd7+OpNl8V2PHhZ8xvtgJds/ON4z7L3rY=";
      }
    ];

    userSettings = { "files.associations" = { "BUCK" = "starlark"; }; };
  };
}
