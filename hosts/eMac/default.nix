{ config, suites, profiles, ... }: {
  imports = with suites; base ++ identity ++ fonts ++ remote-builders;

  tilde.system = { name = "eMac"; };
}
