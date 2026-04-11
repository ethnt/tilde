{ lib, suites, profiles, ... }: {
  imports = with suites;
    base ++ fonts ++ identity ++ [
      profiles.users.ethan
      profiles.builders.builder
      profiles.builders.darwin-linux
    ];

  tilde.host.directory = "/Users/ethan/Workspace/tilde";

  networking.hostName = "eMac";

  homebrew = {
    brews = [
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

    casks = [ "steam" "utm" "vlc" "zoom" ];

    masApps = {
      "Paprika Recipe Manager 3" = 1303222628;
      "Reeder 5" = 1529448980;
      "Tailscale" = 1475387142;
    };
  };

  ids.gids.nixbld = lib.mkOverride 10 30000;
}
