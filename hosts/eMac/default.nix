{ suites, profiles, ... }: {
  imports = with suites; base;

  nix.trustedUsers = [ "ethan" ];

  networking.hostName = "eMac";
}
