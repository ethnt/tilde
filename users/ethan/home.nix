{ config, suites, profiles, pkgs, ... }: {
  imports = with suites;
    base ++ development ++ programming ++ identity ++ [
      profiles.tools.media-management
      profiles.ghostty.default
      profiles.zed.default
    ] ++ [ ./profiles/tmuxp.nix ./profiles/vscode.nix ];

  home.packages = with pkgs; [ borgbackup nixd ];

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
      includes = [{
        path = pkgs.writeText "fern.gitconfig" ''
          [user]
            email = ethan@buildwithfern.com
            signingKey = 0xA49E606DD0CE7B9C
        '';
        condition = "gitdir:$HOME/Workspace/fern/";
      }];
    };
  };

  home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    stateVersion = "24.05";
  };
}
