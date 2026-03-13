{
  programs.git.settings = {
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
}
