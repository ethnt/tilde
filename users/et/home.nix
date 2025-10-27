{ suites, secrets, profiles, ... }: {
  imports = with suites;
    base ++ development ++ identity ++ (with profiles; [ haskell nodejs ])
    ++ [ secrets.users.et.home ] ++ [
      ./profiles/git.nix
      ./profiles/jujutsu.nix
      ./profiles/tmuxp.nix
      ./profiles/tools.nix
      ./profiles/vscode.nix
    ];

  home = {
    username = "et";
    homeDirectory = "/Users/et";

    stateVersion = "24.05";
  };
}
