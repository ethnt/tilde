{ config, pkgs, ... }: {
  home.packages = with pkgs; [ tmux ];

  home.file = {
    ".tmux.conf".source = "${pkgs.oh-my-tmux}/.tmux.conf";
    ".tmux.conf.local".source = ./.tmux.conf.local;
  };

  programs.tmuxp = {
    enable = true;
    workspaces.tilde = {
      session_name = "tilde";
      windows = [{
        focus = true;
        layout = "c5e0,212x37,0,0,3";
        options = { };
        panes = [{
          focus = true;
          shell_command = "direnv reload";
        }];
        start_directory = "${config.tilde.home.homeDirectory}/Workspace/tilde";
        window_name = "fish";
      }];
    };
  };
}
