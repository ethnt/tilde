{ suites, profiles, ... }: {
  imports = with suites;
    base ++ fonts ++ identity ++ [
      profiles.users.ethan
      profiles.builders.builder
    ];

  tilde.host = {
    name = "eMac";
    directory = "/Users/ethan/Workspace/tilde";
    system = "aarch64-darwin";
  };

  homebrew = {
    brews = [ "pinentry-mac" ];

    casks = [ "arc" "docker" "hey" "notion" "tailscale" "utm" "vlc" ];

    masApps = { "Amphetamine" = 937984704; };
  };
}
