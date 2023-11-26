{ profiles }:

with profiles;

{
  base = [
    cachix.default
    darwin.brew
    darwin.common
    darwin.system-defaults
    home-manager.common
    networking.default
    shells.default
  ];

  fonts = with fonts; [ common ];

  identity = [ gpg-agent.default ];

  remote-builders = [ builders.common builders.nix-docker ];
}
