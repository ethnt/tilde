{ pkgs, ... }: {
  programs.vscode = {
    enable = true;

    package = pkgs.vscode;

    mutableExtensionsDir = true;
    enableUpdateCheck = false;

    userSettings = {
      "editor.fontFamily" = "PragmataPro Mono Liga, Operator Mono Lig, mono";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 16;
      "editor.formatOnPaste" = true;
      "editor.insertSpaces" = true;
      "editor.lineHeight" = 25;
      "editor.multiCursorModifier" = "ctrlCmd";
      "editor.rulers" = [ 120 ];
      "editor.tabSize" = 2;

      "terminal.integrated.fontSize" = 16;
      "terminal.integrated.fontWeightBold" = "600";
      "terminal.integrated.lineHeight" = 1.25;

      "explorer.compactFolders" = false;

      "files.insertFinalNewline" = true;
      "files.trimTrailingWhitespace" = true;
      "files.associations" = {
        "Gemfile" = "ruby";
        "Steepfile" = "ruby";
        "Brewfile" = "ruby";
      };

      "ruby.useLanguageServer" = false;
      "ruby.useBundler" = true;
      "ruby.intellisense" = "rubyLocate";

      "nixfmt.path" = "${pkgs.nixfmt}/bin/nixfmt";

      "workbench.colorTheme" = "Solarized Dark";
      "workbench.tree.indent" = 20;
      "workbench.colorCustomizations" = {
        "tree.indentGuidesStroke" = "#21343C";
      };

      "[json]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };

      "[typescriptreact]" = {
        "editor.defaultFormatter" = "vscode.typescript-language-features";
      };

      "[nix]" = { "editor.defaultFormatter" = "brettm12345.nixfmt-vscode"; };

      "explorer.fileNesting.enabled" = true;

      "explorer.fileNesting.patterns" = {
        "*.ts" = "\${capture}.js";
        "*.js" = "\${capture}.js.map, \${capture}.min.js, \${capture}.d.ts";
        "*.jsx" = "\${capture}.js";
        "*.tsx" = "\${capture}.ts";
        "tsconfig.json" = "tsconfig.*.json";
        "package.json" = "package-lock.json, yarn.lock";
      };

      "terminal.integrated.shell.linux" = "fish";

      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;
      "telemetry.telemetryLevel" = "off";

      "update.showReleaseNotes" = false;

      "workbench.welcomePage.walkthroughs.openOnInstall" = false;

      "editor.inlineSuggest.enabled" = false;
    };

    # FIXME: https://github.com/ethnt/tilde/issues/62
    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "nix";
        publisher = "bbenoist";
        version = "1.0.1";
        sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
      }
      {
        name = "atom-keybindings";
        publisher = "ms-vscode";
        version = "3.3.0";
        sha256 = "vzOb/DUV44JMzcuQJgtDB6fOpTKzq298WSSxVKlYE4o=";
      }
      {
        name = "solarized";
        publisher = "ryanolsonx";
        version = "2.1.0";
        sha256 = "HfXNMuUtrqgidSrzFFqeWJhZPQaxP8aw6aYXcT/Exlc=";
      }
      {
        name = "nixfmt-vscode";
        publisher = "brettm12345";
        version = "0.0.1";
        sha256 = "07w35c69vk1l6vipnq3qfack36qcszqxn8j3v332bl0w6m02aa7k";
      }
      {
        name = "project-manager";
        publisher = "alefragnani";
        version = "12.7.0";
        sha256 = "rBMwvm7qUI6zBrXdYntQlY8WvH2fDBhEuQ1pHDl9fQg=";
      }
      {
        name = "alphabetical-sorter";
        publisher = "ue";
        version = "2.0.1";
        sha256 = "1djzba9c2p8h1mx2g104hbcm7fnh296d8j8grm9v3yws0rh2inrg";
      }
      {
        name = "ruby";
        publisher = "rebornix";
        version = "0.28.1";
        sha256 = "HAUdv+2T+neJ5aCGiQ37pCO6x6r57HIUnLm4apg9L50=";
      }
      {
        name = "vscode-ruby";
        publisher = "wingrunr21";
        version = "0.28.0";
        sha256 = "H3f1+c31x+lgCzhgTb0uLg9Bdn3pZyJGPPwfpCYrS70=";
      }
      {
        name = "dhall-lang";
        publisher = "dhall";
        version = "0.0.4";
        sha256 = "7vYQ3To2hIismo9IQWRWwKsu4lXZUh0Or89WDLMmQGk=";
      }
    ];
  };
}
