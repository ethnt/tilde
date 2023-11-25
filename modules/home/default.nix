{ self, ... }:
let
  inherit (self.lib) utils;
  inherit (self.inputs) haumea;
in {
  flake.homeModules = utils.importModules (haumea.lib.load {
    src = ./src;
    loader = haumea.lib.loaders.path;
  });
}
