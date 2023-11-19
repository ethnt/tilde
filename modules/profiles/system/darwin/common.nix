{ config, options, lib, pkgs, ... }: {
  services.activate-system.enable = true;
  services.nix-daemon.enable = true;

  nix = {
    configureBuildUsers = true;
    nixPath = options.nix.nixPath.default ++ [
      "home-manager=https://github.com/rycee/home-manager/archive/master.tar.gz"
    ];
    settings.trusted-users = [ config.tilde.host.primaryUser.username ];
  };

  users.users.${config.tilde.host.primaryUser.username}.home =
    config.tilde.host.homeDirectory;

  environment.darwinConfig =
    "${config.tilde.host.directory}/lib/compat/darwin";

  environment.variables.TILDE_DIR = config.tilde.host.directory;

  system.checks.verifyNixPath = true;
  system.stateVersion = 4;
}
