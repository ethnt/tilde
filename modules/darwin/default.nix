{ self, ... }:
let
  inherit (self) lib;
  inherit (self.inputs) haumea;
in {
  flake.darwinModules = lib.modules.importModules (haumea.lib.load {
    src = ./src;
    loader = haumea.lib.loaders.path;
  });
}
