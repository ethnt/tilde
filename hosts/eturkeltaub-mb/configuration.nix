{ suites, profiles, secrets, ... }: {
  imports = with suites;
    base ++ fonts ++ [
      profiles.users."ethan.turkeltaub"
      secrets.hosts.eturkeltaub-mb.configuration
    ];

  tilde.host = {
    name = "eturkeltaub-mb";
    directory = "/Users/ethan/Workspace/tilde";
    system = "aarch64-darwin";
  };

  homebrew = {
    taps = [ "pantsbuild/tap" ];
    #   brews = [ "pantsbuild/tap/pants" ];
    brews = [
      "awscli" # Pants insists on this being located at `/usr/local/bin`, and Nix can't link there
    ];

    casks = [ "pantsbuild/tap/pants" ];
  };

  homebrew.onActivation.cleanup = "uninstall";
}
