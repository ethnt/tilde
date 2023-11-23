{ profiles }:

with profiles;

{
  base = [
    darwin.common
    darwin.system-defaults
    darwin.brew
    cachix.default
    shells.default
    networking.default
  ];

  fonts = with fonts; [ common pragmatapro ];

  identity = [ gpg-agent.default ];

  remote-builders = [ builders.common builders.nix-docker ];
}
