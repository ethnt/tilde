{ pkgs, ... }: {
  xdg.configFile."zellij/layouts/pills.kdl".text = ''
    layout {
      default_tab_template {
        children
        pane size=1 borderless=false {
          plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
            format_left   "#[fg=#8bd5ca]#[bg=#8bd5ca,fg=#203040,bold]{session}#[fg=#8bd5ca,bg=default] {tabs}"
            format_center ""
            format_right  "{pipe_zjstatus_hints}{mode} #[fg=#89b4fa]#[bg=#89b4fa,fg=#1e2030,bold]{command_hostname}#[fg=#89b4fa,bg=default]"
            format_space  " "
            format_hide_on_overlength "true"
            format_precedence "lcr"

            border_enabled  "false"
            border_char     "─"
            border_format   "#[fg=#6C7086]{char}"
            border_position "top"

            mode_normal      "#[fg=#a6d39f]#[bg=#a6d39f,fg=#203040,bold]NORMAL#[fg=#a6d39f]"
            mode_locked      "#[fg=#6e738d]#[bg=#6e738d,fg=#203040,bold]LOCKED#[fg=#6e738d]"
            mode_resize      "#[fg=#8aadf4]#[bg=#8aadf4,fg=#203040,bold]RESIZE#[fg=#8aadf4]"
            mode_pane        "#[fg=#a6e3a1]#[bg=#a6e3a1,fg=#203040,bold]PANE#[fg=#a6e3a1]"
            mode_move        "#[fg=#f9e2af]#[bg=#f9e2af,fg=#203040,bold]MOVE#[fg=#f9e2af]"
            mode_tab         "#[fg=#89b4fa]#[bg=#89b4fa,fg=#203040,bold]TAB#[fg=#89b4fa]"
            mode_scroll      "#[fg=#cba6f7]#[bg=#cba6f7,fg=#203040,bold]SCROLL#[fg=#cba6f7]"
            mode_search      "#[fg=#f9e2af]#[bg=#f9e2af,fg=#203040,bold]SEARCH#[fg=#f9e2af]"
            mode_entersearch "#[fg=#f9e2af]#[bg=#f9e2af,fg=#203040,bold]ENTER SEARCH#[fg=#f9e2af]"
            mode_renametab   "#[fg=#89b4fa]#[bg=#89b4fa,fg=#203040,bold]RENAME TAB#[fg=#89b4fa]"
            mode_renamepane  "#[fg=#a6e3a1]#[bg=#a6e3a1,fg=#203040,bold]RENAME PANE#[fg=#a6e3a1]"
            mode_session     "#[fg=#f38ba8]#[bg=#f38ba8,fg=#203040,bold]SESSION#[fg=#f38ba8]"
            mode_tmux        "#[fg=#cba6f7]#[bg=#cba6f7,fg=#203040,bold]TMUX#[fg=#cba6f7]"


            tab_normal              "#[fg=#6c7086]#[bg=#6c7086,fg=#1e2030,bold]{index} #[bg=#585b70,fg=#cdd6f4,bold] {name}{floating_indicator}#[fg=#585b70]"
            tab_normal_fullscreen   "#[fg=#6c7086]#[bg=#6c7086,fg=#1e2030,bold]{index} #[bg=#585b70,fg=#cdd6f4,bold] {name}{fullscreen_indicator}#[fg=#585b70]"
            tab_normal_sync         "#[fg=#6c7086]#[bg=#6c7086,fg=#1e2030,bold]{index} #[bg=#585b70,fg=#cdd6f4,bold] {name}{sync_indicator}#[fg=#585b70]"

            tab_active              "#[fg=#eed49f]#[bg=#eed49f,fg=#1e2030,bold]{index} #[bg=#89b4fa,fg=#203040,bold] {name}{floating_indicator}#[fg=#89b4fa]"
            tab_active_fullscreen   "#[fg=#eed49f]#[bg=#eed49f,fg=#1e2030,bold]{index} #[bg=#89b4fa,fg=#203040,bold] {name}{fullscreen_indicator}#[fg=#89b4fa]"
            tab_active_sync         "#[fg=#eed49f]#[bg=#eed49f,fg=#1e2030,bold]{index} #[bg=#89b4fa,fg=#203040,bold] {name}{sync_indicator}#[fg=#89b4fa]"

            tab_rename              "#[fg=#eed49f]#[bg=#eed49f,fg=#1e2030,bold]{index} #[bg=#89b4fa,fg=#203040,bold] {name}{floating_indicator}#[fg=#89b4fa]"

            tab_display_count         "9"
            tab_truncate_start_format "#[fg=#f9e2af] <U+F0D9> +{count} <U+EA7C> "
            tab_truncate_end_format   "#[fg=#f9e2af] <U+EA7C>  +{count} <U+F0DA>"

            tab_separator " "

            tab_sync_indicator       " ⟳"
            tab_fullscreen_indicator " ◉"
            tab_floating_indicator   " ▣"

            command_hostname_command     "hostname"
            command_hostname_format      "#[bg=#89b4fa,fg=#1e2030,bold]{stdout}"
            command_hostname_interval    "0"
            command_hostname_rendermode  "static"
          }
        }
      }
    }
  '';

  programs.zellij = {
    enable = true;
    settings = {
      theme = "nord";
      default_layout = "pills";
      copy_command = "pbcopy";
      copy_on_select = true;
      on_force_close = "detach";
      serialize_pane_viewport = true;
      pane_frames = false;
      show_startup_tips = false;
      show_release_notes = false;
    };
    extraConfig = ''
      keybinds {
          // Release Option+Arrow so the shell receives it for word movement.
          // Keep these keys on one line: Zellij applies only the first
          // top-level `unbind` node.
          unbind "Alt Left" "Alt Right"
          tmux {
              bind "1" { GoToTab 1; SwitchToMode "Normal"; }
              bind "2" { GoToTab 2; SwitchToMode "Normal"; }
              bind "3" { GoToTab 3; SwitchToMode "Normal"; }
              bind "4" { GoToTab 4; SwitchToMode "Normal"; }
              bind "5" { GoToTab 5; SwitchToMode "Normal"; }
              bind "6" { GoToTab 6; SwitchToMode "Normal"; }
              bind "7" { GoToTab 7; SwitchToMode "Normal"; }
              bind "8" { GoToTab 8; SwitchToMode "Normal"; }
              bind "9" { GoToTab 9; SwitchToMode "Normal"; }
              bind "s" {
                  LaunchOrFocusPlugin "session-manager" { floating true; move_to_focused_tab true; };
                  SwitchToMode "Normal";
              }
              bind "w" {
                  LaunchOrFocusPlugin "session-manager" { floating true; move_to_focused_tab true; };
                  SwitchToMode "Normal";
              }
              bind "c" { NewTab; SwitchToMode "Normal"; }
              bind "&" { CloseTab; SwitchToMode "Normal"; }
              bind "x" { CloseFocus; SwitchToMode "Normal"; }
              bind "n" { GoToNextTab; SwitchToMode "Normal"; }
              bind "p" { GoToPreviousTab; SwitchToMode "Normal"; }
              bind "d" { Detach; }
              bind "z" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
              bind "%" { NewPane "Right"; SwitchToMode "Normal"; }
              bind "\"" { NewPane "Down"; SwitchToMode "Normal"; }
              bind "," { SwitchToMode "RenameTab"; TabNameInput 0; }
              bind "[" { SwitchToMode "Scroll"; }
          }
      }
    '';
  };
}
