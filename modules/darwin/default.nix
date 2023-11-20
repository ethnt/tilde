{ self, inputs, ... }:
let
  inherit (inputs) haumea home-manager;
  inherit (self.lib) utils;
in {
  flake.darwinModules_ = utils.flattenTree (haumea.lib.load {
    src = ./src;
    loader = haumea.lib.loaders.path;
    inputs = { inherit haumea; };
  });
}
