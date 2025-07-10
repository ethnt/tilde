{
  programs.tmuxp.workspaces = {
    e10 = {
      session_name = "e10";
      windows = [{
        focus = true;
        layout = "c5e0,212x37,0,0,3";
        options = { };
        panes = [{
          focus = true;
          shell_command = "direnv reload";
        }];
        start_directory = "/Users/ethan/Workspace/e10";
        window_name = "fish";
      }];
    };
  };
}
