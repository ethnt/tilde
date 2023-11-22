{ self, inputs, config, withSystem, ... }:
let
  inherit (inputs) haumea home-manager;
  inherit (self.lib.utils) flattenTree;
  l = inputs.nixpkgs.lib // builtins;
in rec {
  flake = {
    homeModules = builtins.mapAttrs (_: value: (import value))
      (self.lib.utils.flattenTree self.modules.home);
  };
}
