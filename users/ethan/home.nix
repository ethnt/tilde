{ config, lib, pkgs, suites, ... }:

with lib;

{
  imports = with suites;
    (base ++ development ++ programming ++ identity ++ orchard);

  tilde.home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    gpg = { keyId = "0x690FEBBF6380166A"; };
  };

  home.sessionVariables = { KEYID = config.tilde.home.gpg.keyId; };

  programs.git = {
    userEmail = "ethan.turkeltaub@hey.com";
    userName = "Ethan Turkeltaub";
    signing.key = config.tilde.home.gpg.keyId;
  };

  programs.tmuxp.workspaces = {
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

    orchard = {
      session_name = "orchard";
      windows = [{
        focus = true;
        layout = "c5e0,212x37,0,0,3";
        options = { };
        panes = [{
          focus = true;
          shell_command = "direnv reload";
        }];
        start_directory = "/Users/ethan/Workspace/orchard";
        window_name = "fish";
      }];
    };
  };

  home.stateVersion = "22.05";
}
