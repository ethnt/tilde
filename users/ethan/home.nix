{ suites, profiles, pkgs, ... }: {
  imports = (with suites; base ++ development ++ identity)
    ++ (with profiles; [ elixir mise nodejs tools.media-management ruby ])
    ++ [ ./profiles/git.nix ./profiles/tmuxp.nix ./profiles/vscode.nix ];

  home.packages = with pkgs; [ borgbackup nixd ];

  home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    stateVersion = "24.05";
  };
}
