{ suites, secrets, ... }: {
  imports = with suites;
    base ++ development ++ [ secrets.users.et.home ]
    ++ [ ./profiles/tmuxp.nix ./profiles/git.nix ];

  tilde.home = {
    username = "et";
    homeDirectory = "/Users/et";
  };

  home = {
    username = "et";
    homeDirectory = "/Users/et";

    stateVersion = "24.05";
  };
}
