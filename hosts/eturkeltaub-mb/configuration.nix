{ suites, profiles, ... }: {
  imports = with suites; base ++ fonts ++ [ profiles.users."ethan.turkeltaub" ];

  tilde.host = {
    name = "eturkeltaub-mb";
    directory = "/Users/ethan/Workspace/tilde";
    system = "aarch64-darwin";
  };
}
