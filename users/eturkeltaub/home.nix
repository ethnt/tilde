{ config, lib, pkgs, suites, ... }:

with lib;

{
  imports = with suites; (base ++ development) ++ [ ./secrets.nix ];

  tilde.home = {
    username = "eturkeltaub";
    homeDirectory = "/Users/eturkeltaub";
    gpg = { keyId = "AFEEB13E64ED9E7ACD5D5C0B15FF752777F78A43"; };
  };

  home.sessionVariables = { KEYID = config.tilde.home.gpg.keyId; };

  programs.git = {
    userEmail = "eturkeltaub@stripe.com";
    userName = "Ethan Turkeltaub";
    signing.key = config.tilde.home.gpg.keyId;

    aliases = {
      "s" = mkForce "status -uno";
      "co" = ''
        !co() { git checkout "$(git branch --all | ${pkgs.fzf}/bin/fzf | tr -d '[:space:]')"; }; co'';
    };

    extraConfig = {
      push = { default = "simple"; };
      core = { "preloadindex" = true; };
      help = { "autocorrect" = 1; };
      merge = { renameLimit = 10000; };
    };
  };

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
      windows = [{
        focus = true;
        layout = "c5e0,212x37,0,0,3";
        options = { };
        panes = [{
          focus = true;
          shell_command = "direnv reload";
        }];
        start_directory = "/Users/eturkeltaub/personal/tilde";
        window_name = "fish";
      }];
    };
  };
}
