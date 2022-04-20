{ suites, profiles, ... }: {
  imports = with suites; base ++ identity;

  networking.hostName = "eMac";
}
