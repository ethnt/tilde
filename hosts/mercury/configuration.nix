{ suites, profiles, secrets, ... }: {
  imports = with suites;
    base ++ fonts ++ [ secrets.hosts.mercury.configuration ]
    ++ [ profiles.users.et ];

  tilde.host.directory = "/Users/et/Workspace/tilde";

  networking.hostName = "mercury";

  nix.settings = {
    min-free = 21474836480; # 20 GiB
    max-free = 75161927680; # 70 GiB
    max-jobs = "auto";
    warn-dirty = false;
  };

  homebrew.casks = [ "cursor" "figma" "insomnia" "jabra-direct" "linear-linear" "loom" ];
}
