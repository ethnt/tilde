{ suites, profiles, ... }: {
  imports = with suites; (base ++ [ profiles.users.ci ]);

  networking.hostName = "ci";
}
