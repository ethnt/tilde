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

    plugins = with pkgs; [ tmuxPlugins.nord ];

    # TODO: Evaluate if powerline is too slow
    extraConfig = ''
      # Turn on mouse mode
      set -g mouse on

      # Use Powerline
      # run-shell "${pkgs.powerline}/bin/powerline-config tmux setup"
    '';
  };
}
