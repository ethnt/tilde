{ config, suites, profiles, ... }: {
  imports = with suites; base ++ identity ++ fonts;

  tilde.system = { name = "st-eturkeltaub1"; };

  networking.hostName = config.tilde.system.name;
}
