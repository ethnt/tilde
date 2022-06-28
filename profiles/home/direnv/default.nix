{ pkgs, lib, ... }: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    # enableFishIntegration = true;

    # Fixes an issue where the `sed` that macOS provides is different than the one expected and throws invalid command
    # code errors upon entering a cached environment -- this makes it so direnv uses the GNU version of sed
    #
    # See: https://github.com/nix-community/nix-direnv/issues/120#issuecomment-967749893
    stdlib = ''
      sed() { ${pkgs.gnused}/bin/sed "$@"; }
    '';
  };

  # For whatever reason, `programs.direnv.enableFishIntegration` doesn't actually do anything -- manually add the hook
  # in after the rest of the Fish `shellInit`
  programs.fish.shellInit = lib.mkAfter ''
    # direnv
    eval (${pkgs.direnv}/bin/direnv hook fish)
  '';
}
