{ pkgs, lib, ... }: {
  programs.vscode.profiles.default = {
    userSettings = {
      "github.copilot.enable" = lib.mkOverride 10 {
        "*" = true;
        "csharp" = true;
      };
    };

    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-dotnet-runtime";
        publisher = "ms-dotnettools";
        version = "2.3.3";
        sha256 = "l+/r0C+BZr8H8qBKenVP3b4qYGR57Lol+Y1Q2XUGl24=";
      }
      {
        name = "csdevkit";
        publisher = "ms-dotnettools";
        version = "1.19.45";
        sha256 = "ErJ8FjStxwaaJ6f2qew/hY4GTrzC6ZG3MtPGEDmQaHU=";
      }
      {
        name = "csharp";
        publisher = "ms-dotnettools";
        version = "2.72.34";
        sha256 = "d77S13UzAvHF9JBoi/wzh1EDjVAQ6/KugT/zHl6Aj+U=";
      }
      {
        name = "vscodeintellicode-csharp";
        publisher = "ms-dotnettools";
        version = "2.2.3";
        sha256 = "E2KRzjIxLFmwArzEKittjejacrCOFFNNzphWw8v5CpE=";
      }
      {
        name = "graphql";
        publisher = "mquandalle";
        version = "0.1.2";
        sha256 = "0hBtHDD/yk+EpA0A/9ovAz8SUcAoTrXAtHU4Y9MiHnw=";
      }
    ];
  };
}
