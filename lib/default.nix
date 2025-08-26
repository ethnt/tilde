{ inputs, self, withSystem, ... }:
let
  haumea = inputs.haumea.lib;
  lib = haumea.load {
    src = ./src;
    inputs = {
      inherit withSystem;
      flake = self;
    };
  };
in { flake.lib = lib; }
