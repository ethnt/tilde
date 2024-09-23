{ config, suites, profiles, ... }: {
  imports = with suites;
    base ++ development ++ programming ++ identity
    ++ [ profiles.tools.media-management ];

  tilde.home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    gpg = { keyId = "0x690FEBBF6380166A"; };
  };

  programs = {
    git = {
      userEmail = "ethan@turkeltaub.dev";
      userName = "Ethan Turkeltaub";
      signing.key = config.tilde.home.gpg.keyId;
    };

    tmuxp.workspaces = {
      tilde = {
        session_name = "tilde";
        windows = [{
          focus = true;
          layout = "c5e0,212x37,0,0,3";
          options = { };
          panes = [{
            focus = true;
            shell_command = "direnv reload";
          }];
          start_directory = "/Users/ethan/Workspace/tilde";
          window_name = "fish";
        }];
      };

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

    vscode.userSettings = {
      "[astro]" = { "editor.defaultFormatter" = "astro-build.astro-vscode"; };
    };
  };

  home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    stateVersion = "24.05";
  };
}
