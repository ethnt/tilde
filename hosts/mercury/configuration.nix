{ suites, profiles, ... }: {
  imports = with suites; base ++ fonts ++ [ profiles.users.et ];

  tilde.host = {
    name = "mercury";
    directory = "/Users/ethan/Workspace/personal/tilde";
    system = "aarch64-darwin";
  };
}
