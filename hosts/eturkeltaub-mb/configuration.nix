{ suites, profiles, secrets, ... }: {
  imports = with suites;
    base ++ fonts ++ [
      profiles.users."ethan.turkeltaub"
      secrets.hosts.eturkeltaub-mb.configuration
    ];

  tilde.host = {
    name = "eturkeltaub-mb";
    directory = "/Users/ethan/Workspace/tilde";
    system = "aarch64-darwin";
  };

  homebrew.onActivation.cleanup = "uninstall";
}
