{ suites, secrets, ... }: {
  imports = with suites;
    base ++ development ++ identity ++ [ secrets.users.et.home ]
    ++ [ ./profiles/git.nix ./profiles/tmuxp.nix ./profiles/vscode.nix ];

  tilde.home = {
    username = "et";
    homeDirectory = "/Users/et";
    gpg.keyId = "F8E4DBB3201AFD1E";
  };

  home = {
    username = "et";
    homeDirectory = "/Users/et";

    stateVersion = "24.05";
  };
}
