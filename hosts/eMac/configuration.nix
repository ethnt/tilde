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
    brews = [
      "pinentry-mac"
      "postgresql@14"
      # These are to install Ruby via Mise
      # LDFLAGS=-L/opt/homebrew/opt/zlib/lib CPPFLAGS=-I/opt/homebrew/opt/zlib/include mise install ruby@latest
      "autoconf"
      "automake"
      "libtool"
      "zlib"
      "libyaml"
    ];

    taps = [ "homebrew/services" ];

    casks = [
      "arc"
      "cleanshot"
      "docker"
      "elgato-stream-deck"
      "ghostty"
      "hazel"
      "istat-menus"
      "notion"
      "obsidian"
      "steam"
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
