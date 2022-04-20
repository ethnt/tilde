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

      set -g status-style "bg=color233,fg=color247"

      set -g status-left-length "120"
      set -g status-left "#[bg=color226,fg=color0,bold] ❐ #S #[bg=color199,fg=color15,nobold] ↑ #(uptime | cut -f 4-5 -d ' ' | cut -f 1 -d ',') #[bg=color233] "

      set-window-option -g window-status-style bg=colour233,fg=colour247
      set-window-option -g window-status-current-style bg=colour39,fg=colour233,bold
      set-window-option -g window-status-last-style bg=colour236,fg=colour39
      set-window-option -g window-status-format " #I #W#{?window_zoomed_flag,*Z,} "
      set-window-option -g window-status-current-format " #I #W#{?window_zoomed_flag,*Z,} "

      set -g status-left-length "120"
      set -g status-right '%H:%M | %Y-%m-%d #[bg=color160,fg=color15] #(whoami) #[bg=color15,fg=color233,bold] #h '
    '';
  };
}
