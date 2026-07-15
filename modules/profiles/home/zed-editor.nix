{ pkgs, lib, ... }: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "editorconfig"
      "elisp"
      "haskell"
      "html"
      "just"
      "latex"
      "log"
      "make"
      "nix"
      "nord"
      "ruby"
      "sql"
      "starlark"
      "terraform"
      "toml"
      "xml"
    ];
    userSettings = {
      # Keymaps
      base_keymap = "Atom";
      multi_cursor_modifier = "cmd_or_ctrl";

      # Fonts
      ui_font_size = 16;
      buffer_font_family = "PragmataPro Mono Liga";
      buffer_font_size = 16;
      terminal.font_family = "PragmataPro Mono Liga";

      # Theme
      theme = {
        mode = "dark";
        light = "Nord Light";
        dark = "Nord Dark";
      };

      # Ergonomics
      tab_size = 2;
      hard_tabs = false;

      # Hints
      inlay_hints.enabled = true;

      # Git
      git.inline_blame.enabled = false;

      # File associations
      file_types = {
        "Haskell" = [
          "ghci"
          "persistentmodels"
        ];
      };

      # Direnv
      load_direnv = "shell_hook";

      # Language-specific
      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
          formatter = {
            external = {
              command = lib.getExe pkgs.nixfmt;
              arguments = [ ];
            };
          };
        };
      };

      # Telemetry
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      # AI
      show_completions_on_input = false;
    };
  };
}
