{ self, ... }:
let inherit (self) profiles;
in {
  flake.suites = {
    darwin = import ./system.nix { profiles = profiles.darwin; };

    home = import ./home.nix { profiles = profiles.home; };
  };
}
