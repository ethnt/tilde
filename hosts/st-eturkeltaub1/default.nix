{ config, suites, profiles, ... }: {
  imports = with suites; base ++ identity ++ fonts;

  tilde.system = { name = "st-eturkeltaub1"; };

  networking.hostName = config.tilde.system.name;

  # Don't override the SSH known hosts file, it is managed by Stripe IT
  environment.etc."ssh/ssh_known_hosts".enable = false;
}
