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
    brews = [ "pinentry-mac" "postgresql@14" ];

    taps = [ "homebrew/services" ];

    casks = [
      "arc"
      "cleanshot"
      "docker"
      "ghostty"
      "hazel"
      "istat-menus"
      "istat-menus"
      "notion"
      "obsidian"
      "tailscale"
      "utm"
      "vlc"
      "vorta"
      "zoom"
    ];

    masApps = {
      "Amphetamine" = 937984704;
      "Paprika Recipe Manager 3" = 1303222628;
      "Reeder 5" = 1529448980;
      Fantastical = 975937182;
    };
  };
}
