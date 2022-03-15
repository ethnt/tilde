{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    shell = "${config.programs.fish.package}/bin/fish";
    tmuxp = { enable = true; };
  };
}
