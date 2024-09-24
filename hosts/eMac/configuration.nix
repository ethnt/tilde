{ suites, profiles, ... }: {
  imports = with suites;
    base ++ fonts ++ identity ++ [
      profiles.users.ethan
      profiles.builders.builder
      profiles.builders.darwin-linux
    ];

  tilde.host = {
    name = "eMac";
    directory = "/Users/ethan/Workspace/tilde";
    system = "aarch64-darwin";
  };

  homebrew = {
    brews = [ "pinentry-mac" ];

    casks = [
      "arc"
      "cleanshot"
      "docker"
      "hey"
      "istat-menus"
      "notion"
      "tailscale"
      "utm"
      "vlc"
      "zoom"
    ];

    masApps = { "Amphetamine" = 937984704; };
  };
}
