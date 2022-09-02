{ config, suites, profiles, ... }: {
  imports = with suites; base ++ fonts;

  tilde.system = {
    name = "st-eturkeltaub2";
    directory = "/Users/eturkeltaub/personal/tilde";
  };

  nix.settings.extra-platforms = [ "x86_64-darwin" "aarch64-darwin" ];

  # Don't override the SSH known hosts file, it is managed by Stripe IT
  environment.etc."ssh/ssh_known_hosts".enable = false;

  homebrew.casks = [ "keepingyouawake" ];
}
