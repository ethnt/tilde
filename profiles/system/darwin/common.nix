{ config, lib, pkgs, ... }: {
  services.activate-system.enable = true;
  services.nix-daemon.enable = true;

  users.nix.configureBuildUsers = true;

  system.stateVersion = 4;
}
