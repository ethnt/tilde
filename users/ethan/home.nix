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
    };
  };

  home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    stateVersion = "24.05";
  };
}
