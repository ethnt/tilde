{ suites, secrets, ... }: {
  imports = with suites;
    base ++ development ++ identity ++ [ secrets.users.et.home ]
    ++ [ ./profiles/git.nix ./profiles/tmuxp.nix ./profiles/vscode.nix ];

  home = {
    username = "et";
    homeDirectory = "/Users/et";

    stateVersion = "24.05";
  };
}
