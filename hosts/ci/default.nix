{ config, suites, profiles, ... }: {
  imports = with suites; base ++ fonts;

  tilde.system = { name = "ci"; };

  networking.hostName = config.tilde.system.name;
}
