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
      {
        name = "alloglot-mercury";
        publisher = "mercurytechnologiesinc";
        version = "4.0.3";
        sha256 = "cbN2tGMMBR5J3xIQi+mpBvB7Mx+MToGE+UDIEY87ZSI=";
      }
      {
        name = "haskell-yesod-quasiquotes";
        publisher = "mel-brown";
        version = "0.1.1";
        sha256 = "tdudg+Ei2P35IEu5N5+GAqhkTZG5ai3UDHCBz+785Mk=";
      }
      {
        name = "language-yesod";
        publisher = "bigmoon";
        version = "0.9.0";
        sha256 = "77tsTExt+rstjwQGkHIYRckX7KkjiBViMGaWmgRn4+4=";
      }
      {
        name = "vscode-starlark";
        publisher = "phgn";
        version = "0.3.1";
        sha256 = "FM8fZmolsX0uP14nIkZOUJDynJ95krtTL6vzkZybiHY=";
      }
    ];

    userSettings = { "files.associations" = { "BUCK" = "starlark"; }; };
  };
}
