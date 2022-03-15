{ suites, profiles, ... }: {
  # imports = with suites; (base ++ [ profiles.users.ci ]);
  imports = with suites; (base);

  networking.hostName = "ci";
}
