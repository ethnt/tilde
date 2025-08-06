{ suites, profiles, secrets, ... }: {
  imports = with suites;
    base ++ fonts ++ [ secrets.hosts.mercury.configuration ]
    ++ [ profiles.users.et ];

  tilde.host = {
    name = "mercury";
    directory = "/Users/et/Workspace/tilde";
    system = "aarch64-darwin";
  };

  nix.settings = {
    min-free = 21474836480; # 20 GiB
    max-free = 75161927680; # 70 GiB
    max-jobs = "auto";
    warn-dirty = false;
  };

  homebrew = {
    onActivation.cleanup = "zap";

    casks = [ "figma" "linear-linear" "loom" ];
  };
}
