{ profiles }:

with profiles;

{
  base = [
    core.nix-config
    darwin.brew
    darwin.common
    darwin.system-defaults
    home-manager.common
    shells
  ];

  fonts = with fonts; [ common ];

  identity = [ gpg-agent ];

  remote-builders = [ builders.common builders.nix-docker ];
}
