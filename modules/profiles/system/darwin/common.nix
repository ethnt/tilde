{ config, ... }: {
  services.activate-system.enable = true;
  services.nix-daemon.enable = true;

  nix = {
    configureBuildUsers = true;

    settings = {
      trusted-users = [ config.tilde.host.primaryUser.username ];
      extra-experimental-features = [ "nix-command" "flakes" ];
    };
  };

  users.users.${config.tilde.host.primaryUser.username}.home =
    config.tilde.host.primaryUser.homeDirectory;

  environment.darwinConfig = "${config.tilde.host.directory}/lib/compat/darwin";

  environment.variables.TILDE_DIR = config.tilde.host.directory;

  system.checks.verifyNixPath = true;
  system.stateVersion = 4;
}
