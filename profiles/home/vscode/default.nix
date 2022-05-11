{ pkgs, ... }: {
  programs.vscode = {
    enable = true;

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

      "[json]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };

      "[typescriptreact]" = {
        "editor.defaultFormatter" = "vscode.typescript-language-features";
      };

      "explorer.fileNesting.enabled" = true;

      "explorer.fileNesting.patterns" = {
        "*.ts" = "\${capture}.js";
        "*.js" = "\${capture}.js.map, \${capture}.min.js, \${capture}.d.ts";
        "*.jsx" = "\${capture}.js";
        "*.tsx" = "\${capture}.ts";
        "tsconfig.json" = "tsconfig.*.json";
        "package.json" = "package-lock.json, yarn.lock";
        "flake.nix" = "flake.lock";
      };
    };

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
        version = "3.0.9";
        sha256 = "04jqc6i5qybkl7y90m40f7fi8njdafdgmpvna8z7cvz9ibjbpv21";
      }
      {
        name = "solarized";
        publisher = "ryanolsonx";
        version = "2.0.3";
        sha256 = "071z473syygqln9qk4bbs90yq7x2j2wsswvhm6aphw9lv8pcm69h";
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
        version = "12.0.1";
        sha256 = "1bckjq1dw2mwr1zxx3dxs4b2arvnxcr32af2gxlkh4s26hvp9n1v";
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
        version = "0.27.0";
        sha256 = "1y0fvciqxkj7nwvh4x25vrjfk1rym9h5fd38s89qfla36ac88fpr";
      }
      {
        name = "vscode-ruby";
        publisher = "wingrunr21";
        version = "0.27.0";
        sha256 = "0sd78x44brcmwj0baam58j1j9gx57w7xq52y77jjyrwlac5fxsr8";
      }
      {
        name = "gitlens";
        publisher = "eamodio";
        version = "11.0.6";
        sha256 = "0qlaq7hn3m73rx9bmbzz3rc7khg0kw948z2j4rd8gdmmryy217yw";
      }
    ];
  };
}
