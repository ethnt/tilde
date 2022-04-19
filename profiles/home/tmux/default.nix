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

      # # Status bar theming
      # set -g status-position bottom
      # set -g status-justify left

      # set -g status-bg black
      # set -g status-fg white

      # set -g status-left " #[fg=black,bg=yellow] #S "

      # set -g status-right " #[fg=black,bg=yellow]#(uptime | awk '{print $1}') #[fg=white,bg=red] #h "

      # setw -g window-status-format " #I#[fg=white] #[fg=white]#W#[fg=white]#F "
      # setw -g window-status-current-style " fg=black bg=cyan bold "
      # setw -g window-status-current-format " #I#[fg=white] #[fg=white]#W#[fg=white]#F "
    '';
  };
}
