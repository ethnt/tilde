{ self, ... }:
let inherit (self.lib) utils;
in { flake.homeModules = utils.importModules self.modules.home; }
