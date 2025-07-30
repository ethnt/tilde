{ suites, profiles, ... }: {
  imports = with suites; base ++ fonts ++ [ profiles.users.et ];

  tilde.host = {
    name = "mercury";
    directory = "/Users/et/Workspace/tilde";
    system = "aarch64-darwin";
  };
}
