{ pkgs, ... }: {
  programs.mise = {
    enable = true;
    enableFishIntegration = true;
    package = pkgs.mise;
    settings = {
      asdf_compat = true;
      legacy_version_file = true;
      idiomatic_version_file_enable_tools = [ "node" ];
    };
  };
}
