{ suites, profiles, ... }: {
  imports = with suites; (base ++ [ profiles.users.ethan ]);

  networking.hostName = "eMac";
}
