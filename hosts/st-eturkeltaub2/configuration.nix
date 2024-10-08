{ suites, profiles, lib, ... }: {
  imports = with suites; base ++ fonts ++ [ profiles.users.eturkeltaub ];

  tilde.host = {
    name = "st-eturkeltaub2";
    directory = "/Users/eturkeltaub/personal/tilde";
    system = "aarch64-darwin";
  };

  # Don't override the SSH known hosts file, it is managed by Stripe IT
  environment.etc."ssh/ssh_known_hosts".enable = false;

  homebrew = {
    # Don't clean up undefined brews/casks, some are installed by Stripe IT
    onActivation.cleanup = lib.mkOverride 10 "none";

    # FIXME: $PATH doesn't pick up nix's `gnused` before the system one, but it does pick up the Homebrew version
    # https://github.com/ethnt/tilde/issues/71
    brews = [ "gnu-sed" ];

    casks = [ "asana" "figma" "keepingyouawake" "monitorcontrol" "obsidian" ];

    masApps = { "Omnifocus 3" = 1346203938; };
  };
}
