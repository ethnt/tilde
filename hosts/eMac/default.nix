{ suites, profiles, ... }: {
  imports = with suites; (base);

  networking.hostName = "eMac";
}
