{ config, lib, pkgs, ... }: {
  services.activate-system.enable = true;
  services.nix-daemon.enable = true;

  nix.trustedUsers = [ config.tilde.system.username ];

  users.users.${config.tilde.system.username}.home = config.tilde.system.homeDirectory;

  users.nix.configureBuildUsers = true;

  environment.darwinConfig = "${config.tilde.system.directory}/lib/compat/darwin";

  system.checks.verifyNixPath = true;
  system.stateVersion = 4;
}
