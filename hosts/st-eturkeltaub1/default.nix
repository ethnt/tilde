{ config, suites, profiles, ... }: {
  imports = with suites; base ++ fonts;

  tilde.system = { name = "st-eturkeltaub1"; };

  # Don't override the SSH known hosts file, it is managed by Stripe IT
  environment.etc."ssh/ssh_known_hosts".enable = false;
}
