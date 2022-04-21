{ config, pkgs, ... }: {
  home.packages = with pkgs; [ tmux ];

  home.file.".tmux.conf".source = "${pkgs.oh-my-tmux}/.tmux.conf";
  home.file.".tmux.conf.local".source = ./.tmux.conf.local;
}
