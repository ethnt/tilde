{ config, suites, profiles, ... }: {
  imports = with suites; base ++ [ profiles.users.ethan ];

  tilde.host = {
    name = "eMac";
    directory = "/Users/ethan/Workspace/tilde";
    system = "x86_64-darwin";
  };
}
