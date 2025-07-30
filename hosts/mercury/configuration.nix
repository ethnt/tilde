{ suites, profiles, secrets, ... }: {
  imports = with suites;
    base ++ fonts ++ [ secrets.hosts.mercury.configuration ]
    ++ [ profiles.users.et ];

  tilde.host = {
    name = "mercury";
    directory = "/Users/et/Workspace/tilde";
    system = "aarch64-darwin";
  };
}
