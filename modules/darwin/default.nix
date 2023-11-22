{ self, ... }:
let inherit (self.lib) utils;
in { flake.darwinModules = utils.importModules self.modules.darwin; }
