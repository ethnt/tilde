{ config, pkgs, suites, secrets, ... }: rec {
  imports = let
    tilde-secrets = builtins.getFlake
      "git+ssh://git@github.com/ethnt/tilde-secrets?rev=04fd160e6d3d229260bacebbf590edc15c2f6dcc";

  in with suites;
  (base ++ development ++ work)
  ++ [ tilde-secrets.secrets.home.users.eturkeltaub ];

  tilde.home = {
    username = "eturkeltaub";
    homeDirectory = "/Users/eturkeltaub";
    gpg = { keyId = "4FF658525A04B618E0376A8854CFB5EB45626324"; };
  };

  home.sessionVariables.KEYID = config.tilde.home.gpg.keyId;

  programs = {
    git = {
      userEmail = "eturkeltaub@stripe.com";
      userName = "Ethan Turkeltaub";
      signing.key = config.tilde.home.gpg.keyId;
    };

    vscode = {
      userSettings = { "update.mode" = "none"; };

      extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
        name = "vscode-bazel";
        publisher = "bazelbuild";
        version = "0.9.0";
        sha256 = "XrRrspvUbqDNOTN5FZExydOANrxLYatD+9MEQUCllxU=";
      }];
    };

    starship = {
      settings = {
        git_status = { disabled = true; };
        aws = { disabled = true; };
        gcloud = { disabled = true; };
        nodejs = { disabled = true; };
        openstack = { disabled = true; };
        ruby = { disabled = true; };
      };
    };

    tmuxp.workspaces = {
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
  };

  home = {
    username = "eturkeltaub";
    homeDirectory = "/Users/eturkeltaub";
    stateVersion = "23.05";
  };
}
