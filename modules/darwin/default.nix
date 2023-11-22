{ self, inputs, ... }:
let
  inherit (inputs) haumea;
  inherit (self.lib) utils;
in {
  flake.darwinModules = builtins.mapAttrs (_: value: (import value))
    (utils.flattenTree self.modules.darwin);
}
