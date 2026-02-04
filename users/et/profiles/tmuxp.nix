{ config, ... }: {
  programs.tmuxp.workspaces = {
    tilde = {
      session_name = "tilde";
      windows = [
        {
          focus = true;
          layout = "c5e0,212x37,0,0,3";
          options = { };
          panes = [{
            focus = true;
            shell_command = "direnv reload";
          }];
          start_directory =
            "${config.home.homeDirectory}/Workspace/personal/tilde";
          window_name = "tilde";
        }
        {
          focus = false;
          layout = "c5e0,212x37,0,0,3";
          options = { };
          panes = [{
            focus = true;
            shell_command = "direnv reload";
          }];
          start_directory =
            "${config.home.homeDirectory}/Workspace/personal/tilde-secrets";
          window_name = "tilde-secrets";
        }
      ];
    };
  };
}
