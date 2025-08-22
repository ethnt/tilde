{ suites, profiles, pkgs, ... }: {
  imports = (with suites; base ++ development ++ identity) ++ (with profiles; [
    elixir
    mise
    nodejs
    tools.media-management
    zed.default
    ruby
  ]) ++ [ ./profiles/git.nix ./profiles/tmuxp.nix ./profiles/vscode.nix ];

  home.packages = with pkgs; [ borgbackup nixd ];

  tilde.home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    gpg = { keyId = "0x690FEBBF6380166A"; };
  };

  home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    stateVersion = "24.05";
  };
}
