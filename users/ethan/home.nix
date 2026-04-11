{ suites, profiles, config, pkgs, ... }: {
  imports = (with suites; base ++ development ++ identity)
    ++ (with profiles; [ elixir mise nodejs tools.media-management ruby ]) ++ [
      ./profiles/git.nix
      ./profiles/jujutsu.nix
      ./profiles/tmuxp.nix
      ./profiles/vscode.nix
    ];

  home.packages = with pkgs; [ restic nixd ];

  home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    stateVersion = "24.05";
  };

  sops.secrets.biz = { path = "${config.home.homeDirectory}/biz.txt"; };
}
