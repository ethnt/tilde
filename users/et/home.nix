{ suites, secrets, profiles, ... }: {
  imports = with suites;
    base ++ development ++ work ++ identity
    ++ (with profiles; [ haskell nodejs ]) ++ [ secrets.users.et.home ] ++ [
      ./profiles/git.nix
      ./profiles/jujutsu.nix
      ./profiles/mcp/figma.nix
      ./profiles/mcp/firehydrant/default.nix
      ./profiles/mcp/grafana/default.nix
      ./profiles/mcp/honeycomb.nix
      ./profiles/mcp/linear.nix
      ./profiles/mcp/notion.nix
      ./profiles/mcp/postgres/default.nix
      ./profiles/mcp/sentry.nix
      ./profiles/opencode/default.nix
      ./profiles/tmuxp.nix
      ./profiles/tools.nix
      ./profiles/vscode.nix
    ];

  home = {
    username = "et";
    homeDirectory = "/Users/et";

    stateVersion = "26.05";
  };
}
