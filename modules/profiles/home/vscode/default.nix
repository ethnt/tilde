{ pkgs, lib, ... }: {
  programs.vscode = {
    enable = true;

    package = pkgs.vscode;

    mutableExtensionsDir = true;
    enableUpdateCheck = false;

    userSettings = {
      # Workbench/frame settings
      "workbench.colorCustomizations"."tree.indentGuidesStroke" = "#21343C";
      "workbench.colorTheme" = "Solarized Dark";
      "workbench.startupEditor" = "none";
      "workbench.tree.indent" = 20;
      "workbench.welcomePage.walkthroughs.openOnInstall" = false;

      # Editor settings
      "editor.fontFamily" = "PragmataPro Mono Liga, Operator Mono Lig, mono";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 16;
      "editor.formatOnPaste" = true;
      "editor.inlineSuggest.enabled" = false;
      "editor.insertSpaces" = true;
      "editor.lineHeight" = 25;
      "editor.multiCursorModifier" = "ctrlCmd";
      "editor.rulers" = [ 120 ];
      "editor.tabSize" = 2;
      "editor.stickyScroll.enabled" = true;

      # Terminal settings
      "terminal.integrated.fontSize" = 16;
      "terminal.integrated.fontWeightBold" = "600";
      "terminal.integrated.lineHeight" = 1.25;
      "terminal.integrated.shell.linux" = lib.getExe pkgs.fish;

      # File explorer settings
      "explorer.compactFolders" = false;
      "explorer.fileNesting.enabled" = true;
      "explorer.fileNesting.patterns" = {
        "*.js" = "\${capture}.js.map, \${capture}.min.js, \${capture}.d.ts";
        "*.jsx" = "\${capture}.js";
        "*.ts" = "\${capture}.js";
        "*.tsx" = "\${capture}.ts";
        "package.json" = "package-lock.json, yarn.lock";
        "tsconfig.json" = "tsconfig.*.json";
      };

      # File editing settings
      "files.insertFinalNewline" = true;
      "files.trimTrailingWhitespace" = true;

      # Telemetry settings
      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;
      "telemetry.telemetryLevel" = "off";

      # Update settings
      "update.showReleaseNotes" = false;

      # Filename associations
      "files.associations" = {
        "Brewfile" = "ruby";
        "Gemfile" = "ruby";
        "Steepfile" = "ruby";
      };

      # Extension settings
      "extensions.ignoreRecommendations" = true;

      # Ruby settings
      "ruby.intellisense" = "rubyLocate";
      "ruby.useBundler" = true;
      "ruby.useLanguageServer" = false;

      # Nix settings
      "[nix]" = { "editor.defaultFormatter" = "brettm12345.nixfmt-vscode"; };
      "nixfmt.path" = lib.getExe pkgs.nixfmt-classic;

      # JSON settings
      "[json]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };

      # TypeScript settings
      "[typescriptreact]" = {
        "editor.defaultFormatter" = "vscode.typescript-language-features";
      };
    };

    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "nix-ide";
        publisher = "jnoortheen";
        version = "0.3.5";
        sha256 = "jwOM+6LnHyCkvhOTVSTUZvgx77jAg6hFCCpBqY8AxIg=";
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
        version = "2.5.0";
        sha256 = "zhxiI7OHf8IzgIEXchA2k2bS30+BNPOUN8JrDFfjqzY=";
      }
      {
        name = "nixfmt-vscode";
        publisher = "brettm12345";
        version = "0.0.1";
        sha256 = "07w35c69vk1l6vipnq3qfack36qcszqxn8j3v332bl0w6m02aa7k";
      }
      {
        name = "alphabetical-sorter";
        publisher = "ue";
        version = "2.0.1";
        sha256 = "1djzba9c2p8h1mx2g104hbcm7fnh296d8j8grm9v3yws0rh2inrg";
      }
      {
        name = "vscode-ruby-syntax";
        publisher = "SarahRidge";
        version = "0.0.11";
        sha256 = "FbWBCACmCeS0douIR15WvI3/QVHlI8GTnLNdmTnehW0=";
      }
      {
        name = "ruby-lsp";
        publisher = "shopify";
        version = "0.7.20";
        sha256 = "cQPNd5u0QRBBEZpla4CavEKFwfxcS9itIdSoWhyP1Uc=";
      }
      {
        name = "bookmarks";
        publisher = "alefragnani";
        version = "13.5.0";
        sha256 = "oKhd5BLa2wuGNrzW9yKsWWzaU5hNolw2pBcqPlql9Ro=";
      }
    ];
  };
}
