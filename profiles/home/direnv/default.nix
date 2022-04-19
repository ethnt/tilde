{ pkgs, lib, ... }: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    nix-direnv.enableFlakes = true;
  };

  home.enableNixpkgsReleaseCheck = true;
}
