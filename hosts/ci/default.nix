{ config, suites, profiles, ... }: {
  imports = with suites; base;

  tilde.system = {
    name = "ci";
  };

  networking.hostName = config.tilde.system.name;
}
