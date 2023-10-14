{ self, inputs, ... }:
let
  inherit (inputs) haumea;
  inherit (self.lib.utils) flattenTree;
  l = inputs.nixpkgs.lib // builtins;
in {
  flake.homeModules = l.attrValues (flattenTree (haumea.lib.load {
    src = ./src;
    loader = haumea.lib.loaders.path;
  }));
}
