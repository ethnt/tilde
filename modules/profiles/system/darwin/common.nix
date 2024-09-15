{ flake, config, ... }: {
  services.activate-system.enable = true;
  services.nix-daemon.enable = true;

  nix = {
    configureBuildUsers = true;

    settings = {
      trusted-users = [ config.tilde.host.primaryUser.username ];
      extra-nix-path = [ "darwin-config=${flake}/lib/compat/darwin" ];
      extra-experimental-features = [ "nix-command" "flakes" "ca-derivations" ];
    };
  };

  users.users.${config.tilde.host.primaryUser.username}.home =
    config.tilde.host.primaryUser.homeDirectory;

  # BUG: This has no effect in most shells
  # https://github.com/LnL7/nix-darwin/issues/428
  # environment.darwinConfig = "${config.tilde.host.directory}/lib/compat/darwin";

  environment.variables.TILDE_DIR = config.tilde.host.directory;

  system.checks.verifyNixPath = true;
  system.stateVersion = 4;
}
