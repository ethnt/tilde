{ config, lib, pkgs, ... }: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [ nix-direnv ];

  programs.zsh.initContent = lib.mkAfter ''
    eval "$(${lib.getExe config.programs.direnv.package} hook zsh)"
  '';
}
