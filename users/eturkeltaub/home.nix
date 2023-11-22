{ config, suites, ... }: {
  imports = with suites; base ++ development ++ work;

  tilde.home = {
    username = "ethan";
    homeDirectory = "/Users/eturkeltaub";
    gpg = { keyId = "4FF658525A04B618E0376A8854CFB5EB45626324"; };
  };

  home.sessionVariables.KEYID = config.tilde.home.gpg.keyId;

  programs.git = {
    userEmail = "eturkeltaub@stripe.com";
    userName = "Ethan Turkeltaub";
    signing.key = config.tilde.home.gpg.keyId;
  };

  programs.vscode.userSettings = { "update.mode" = "none"; };

  programs.starship = {
    settings = {
      git_status = { disabled = true; };
      aws = { disabled = true; };
      gcloud = { disabled = true; };
      nodejs = { disabled = true; };
      openstack = { disabled = true; };
      ruby = { disabled = true; };
    };
  };

  programs.tmuxp.workspaces = {
    tilde = {
      session_name = "tilde";
      start_directory = "/Users/eturkeltaub/personal/tilde";
      windows = [{
        focus = true;
        layout = "c5e0,212x37,0,0,3";
        options = { };
        panes = [{
          focus = true;
          shell_command = "direnv reload";
        }];
        window_name = "fish";
      }];
    };
  };

  home.username = "eturkeltaub";
  home.homeDirectory = "/Users/eturkeltaub";
  home.stateVersion = "23.05";
}
