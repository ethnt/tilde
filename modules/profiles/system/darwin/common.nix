{ config, options, lib, pkgs, ... }: {
  services.activate-system.enable = true;
  services.nix-daemon.enable = true;

  nix = {
    configureBuildUsers = true;
    nixPath = options.nix.nixPath.default ++ [
      "home-manager=https://github.com/rycee/home-manager/archive/master.tar.gz"
    ];
    settings.trusted-users = [ config.tilde.system.username ];
  };

  users.users.${config.tilde.system.username}.home =
    config.tilde.system.homeDirectory;

  environment.darwinConfig =
    "${config.tilde.system.directory}/lib/compat/darwin";

  environment.variables.TILDE_DIR = config.tilde.system.directory;

  system.checks.verifyNixPath = true;
  system.stateVersion = 4;
}
