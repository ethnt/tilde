{ pkgs, lib, ... }: {
  programs.mise = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      asdf_compat = true;
      legacy_version_file = true;
    };
  };

  home.packages = with pkgs; [ openssl ];

  programs.fish.shellInit = lib.mkAfter ''
    set -U OPENSSL_DIR ${lib.getDev pkgs.openssl}
    set -U OPENSSL_LIB_DIR ${lib.getDev pkgs.openssl}/lib
  '';

  # For whatever reason, `programs.mise.enableFishIntegration` doesn't actually do anything -- manually add the hook
  # in after the rest of the Fish `shellInit`
  # programs.fish.shellInit = lib.mkAfter ''
  #   # mise
  #   eval (${pkgs.mise}/bin/mise activate)
  # '';
}
