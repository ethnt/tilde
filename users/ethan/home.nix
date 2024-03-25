{ config, pkgs, lib, suites, profiles, ... }: {
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
      userEmail = "ethan.turkeltaub@hey.com";
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

    vscode = {
      userSettings = {
        "[astro]" = { "editor.defaultFormatter" = "astro-build.astro-vscode"; };

        "[terraform]" = { "editor.defaultFormatter" = "hashicorp.terraform"; };
      };

      extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "elixir-ls";
          publisher = "jakebecker";
          version = "0.20.0";
          sha256 = "p+YNBRzzA/EezBMxI5Rmdb8SdJgFV7QwuLVi1mcJV+E=";
        }
        {
          name = "terraform";
          publisher = "HashiCorp";
          version = "2.30.2024022914";
          sha256 = "HkLMSpI/xgcHTJyZrOPzuTyFwaDXi7f4xKYnI7f/WGU=";
        }
        {
          name = "astro-vscode";
          publisher = "astro-build";
          version = "2.8.4";
          sha256 = "wR+4erGkbzQ4R9UH3HOxSq0ZELVYp1LaYDWGMdtJ0mE=";
        }
      ];
    };
  };

  home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    stateVersion = "23.05";
  };
}
