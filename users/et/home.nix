{ suites, secrets, pkgs, ... }: {
  imports = with suites;
    base ++ development ++ identity ++ [ secrets.users.et.home ] ++ [
      ./profiles/git.nix
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
