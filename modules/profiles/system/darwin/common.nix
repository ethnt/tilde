{ flake, config, ... }: {
  # TODO: It is unclear to me why this needs to be set in addition to `nix.settings.extra-nix-path`
  nix.nixPath = [ "darwin-config=${flake}/lib/compat/darwin" ];

  nix = {
    settings = {
      trusted-users = [ config.system.primaryUser ];
      extra-nix-path = [ "darwin-config=${flake}/lib/compat/darwin" ];
      extra-experimental-features = [ "nix-command" "flakes" ];
    };
  };

  users.users.${config.system.primaryUser}.home = config.system.primaryUserHome;

  # BUG: This has no effect in most shells
  # https://github.com/LnL7/nix-darwin/issues/428
  environment.darwinConfig = "${config.tilde.host.directory}/lib/compat/darwin";

  # BUG: Disable until this is merged into the nix-darwin 25.05 branch:
  # https://github.com/nix-darwin/nix-darwin/pull/1500
  # system.checks.verifyNixPath = true;
  system.stateVersion = 4;

  ids.gids.nixbld = 350;
}
