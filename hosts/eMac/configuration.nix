{ suites, profiles, ... }: {
  imports = with suites; base ++ fonts ++ identity ++ [ profiles.users.ethan ];

  tilde.host = {
    name = "eMac";
    directory = "/Users/ethan/Workspace/tilde";
    system = "aarch64-darwin";
  };
}
