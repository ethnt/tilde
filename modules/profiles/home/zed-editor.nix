{ config, pkgs, lib, ... }: {
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" "nord" ];
    userSettings = {
      # Keymaps
      base_keymap = "Atom";
      multi_cursor_modifier = "cmd_or_ctrl";

      # Fonts
      ui_font_size = 16;
      buffer_font_family = "PragmataPro Mono Liga";
      buffer_font_size = 16;

      # Theme
      theme = {
        mode = "dark";
        light = "Nord Light";
        dark = "Nord Dark";
      };

      # Ergonomics
      tab_size = 2;
      hard_tabs = false;

      # Git
      git.inline_blame.enabled = false;

      # Language-specific
      languages = {
        Nix = {
          language_servers = [ "nixd" "!nil" ];
          formatter = {
            external = {
              command = lib.getExe pkgs.nixfmt-classic;
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
      show_edit_predictions = false;
    };

    userTasks = [{
      label = "file_finder";
      command = ''
        ${lib.getExe config.programs.zed-editor.package} "$(${
          lib.getExe config.programs.television.package
        } files)"'';
      hide = "always";
      allow_concurrent_runs = true;
      use_new_terminal = true;
    }];

    userKeymaps = [{
      context = "Workspace";
      bindings = {
        cmd-p = [
          "task::Spawn"
          {
            task_name = "file_finder";
            reveal_target = "center";
          }
        ];
      };
    }];
  };

  home.packages = with pkgs; [ television ];
}
