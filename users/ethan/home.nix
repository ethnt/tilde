{ config, suites, profiles, pkgs, ... }: {
  imports = with suites;
    base ++ development ++ identity ++ [
      elixir.default
      mise.default
      nodejs.default
      profiles.tools.media-management
      profiles.zed.default
      ruby.default
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
