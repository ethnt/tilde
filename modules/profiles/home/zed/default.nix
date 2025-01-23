{ lib, pkgs, ... }: {
  programs.zed-editor = {
    enable = true;
    extensions = [ "astro" "elixir" "html" "just" "nix" ];
    userSettings = {
      theme = {
        mode = "dark";
        light = "Nordic";
        dark = "Nordic";
      };

      buffer_font_family = "PragmataPro Mono Liga";
      buffer_font_size = 16;
      buffer_line_height = "comfortable";

      ui_font_family = ".SystemUIFont";
      ui_font_size = 16;

      project_panel = { auto_fold_dirs = false; };

      base_keymap = "Atom";

      languages = {
        Nix = {
          language_servers = [ "nixd" "!nil" ];
          formatter.external.command = lib.getExe pkgs.nixfmt-classic;
        };
      };
    };
  };

  xdg.configFile."zed/themes/nordic.json".source = ./themes/nordic.json;
}
