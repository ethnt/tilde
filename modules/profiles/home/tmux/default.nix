{ config, pkgs, ... }: {
  home.packages = with pkgs; [ tmux ];

  home.file = {
    ".tmux.conf".source = "${pkgs.oh-my-tmux}/.tmux.conf";
    ".tmux.conf.local".source = ./.tmux.conf.local;
  };

  programs.tmuxp.enable = true;
}
