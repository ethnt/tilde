{ config, suites, profiles, ... }: {
  imports = with suites; base ++ identity;

  tilde.system = { name = "eMac"; };

  networking.hostName = config.tilde.system.name;
}
