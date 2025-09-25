{
  programs.zellij.enable = true;

  xdg.configFile = {
    "zellij/config.kdl".text = ''
      theme "nord"
      mouse_mode true

      show_startup_tips false
      show_release_notes false

      keybinds {
        normal {
          // https://github.com/zellij-org/zellij/issues/4151#issuecomment-2976947187
          unbind "Alt f"
          bind "Alt F" { ToggleFloatingPanes; }
        }
      }
    '';

    "zellij/layouts/compact.kdl".text = ''
      layout {
        pane split_direction="vertical" {
          pane
        }
        pane size=1 borderless=true {
          plugin location="zellij:compact-bar"
        }
      }
    '';
  };
}
