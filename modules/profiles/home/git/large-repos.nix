{ lib, ... }:

with lib;

{
  programs.git = {
    aliases.s = mkOverride 10 "status -uno";
    extraConfig = {
      core = {
        compression = 9;
        packedgitwindowsize = "32g";
        preloadindex = true;
        deltabasecachelimit = "2g";
      };
      feature.manyfiles = true;
      fetch.prune = true;
      merge.renameLimit = 10000;
      push.default = "simple";
    };
  };
}
