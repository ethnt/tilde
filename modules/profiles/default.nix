{ self, ... }:
let inherit (self.inputs) haumea;
in {
  flake.profiles = {
    darwin = haumea.lib.load {
      src = ./system;
      loader = haumea.lib.loaders.path;
    };

    home = haumea.lib.load {
      src = ./home;
      loader = haumea.lib.loaders.path;
    };
  };
}
