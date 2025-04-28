{ pkgs, inputs, ... }: {
  programs.mise = {
    enable = true;
    enableFishIntegration = true;
    package = inputs.mise.packages.${pkgs.system}.default;
    settings = {
      asdf_compat = true;
      legacy_version_file = true;
    };
  };
}
