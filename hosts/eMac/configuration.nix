{ suites, profiles, ... }: {
  imports = with suites;
    base ++ fonts ++ identity ++ [
      profiles.users.ethan
      profiles.builders.common
      profiles.builders.darwin-linux
      profiles.builders.nix-docker
    ];

  tilde.host = {
    name = "eMac";
    directory = "/Users/ethan/Workspace/tilde";
    system = "aarch64-darwin";
  };

  homebrew = {
    brews = [ "pinentry-mac" ];

    casks = [ "arc" "dash" "docker" "tailscale" "utm" ];
  };
}
