{ lib, ... }:

with lib;

{
  programs.git = {
    aliases = { s = mkOverride 10 "status -uno"; };
    extraConfig = {
      core = {
        preloadindex = true;
        deltabasecachelimit = "4g";
      };
      feature.manyfiles = true;
      fetch.prune = true;
      merge = { renameLimit = 10000; };
      push = { default = "simple"; };
    };
  };
}
