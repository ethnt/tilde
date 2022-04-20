{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    shell = "${config.programs.fish.package}/bin/fish";
    terminal = "screen-256color";

    sensibleOnTop = true;

    tmuxp = { enable = true; };

    aggressiveResize = true;
    baseIndex = 1;
    escapeTime = 0;

    extraConfig = ''
      # Turn on mouse mode
      set -g mouse on

      # Make sure we know if activity is happening, but don't actually show it in text form
      set -g monitor-activity on
      set -g visual-activity off

      # Numbering of panes and windows
      set -g base-index 1
      setw -g pane-base-index 1

      # Rename and renumber windows on change
      setw -g automatic-rename on
      set -g renumber-windows on

      # Turn on titles
      set -g set-titles on

      # Slightly longer pane indicator time
      set -g display-panes-time 800
      set -g display-time 1000

      # Redraw status line every 10 seconds
      set -g status-interval 10

      # Clear both screen and history
      bind -n C-l send-keys C-l \; run 'sleep 0.2' \; clear-history

      # Set the base status bar colors
      set -g status-style "bg=color233,fg=color247"

      # Left section of the status bar
      set -g status-left-length "120"
      set -g status-left "#[bg=color226,fg=color0,bold] ❐ #S #[bg=color199,fg=color15,nobold] ↑ #(uptime | cut -f 4-5 -d ' ' | cut -f 1 -d ',') #[bg=color233] "

      # Styling and formatting for each window type
      setw -g window-status-style bg=color233,fg=color247
      setw -g window-status-current-style bg=color39,fg=color233,bold
      setw -g window-status-last-style bg=color236,fg=color39
      setw -g window-status-activity-style underscore
      setw -g window-status-format " #I #W#{?window_zoomed_flag,*Z,} "
      setw -g window-status-current-format " #I #W#{?window_zoomed_flag,*Z,} "

      # Right section of the status bar
      set -g status-left-length "120"
      set -g status-right '%H:%M | %Y-%m-%d #[bg=color160,fg=color15] #(whoami) #[bg=color15,fg=color233,bold] #h '

      # Pane styling
      set -g pane-border-style fg=color236
      set -g pane-active-border-style fg=color39
    '';
  };
}
