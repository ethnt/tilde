{ config, flake, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      suites = flake.suites.home;
      profiles = flake.profiles.home;
    };
  };

  # These are shared modules because they require configuration from the system, not the home configuration
  home-manager.sharedModules = [{
    home.sessionVariables = {
      # environment.sessionVariables is not currently available in nix-darwin
      NIX_PATH =
        config.environment.sessionVariables.NIX_PATH or config.environment.variables.NIX_PATH;

      TILDE_DIR =
        config.environment.sessionVariables.TILDE_DIR or config.environment.variables.TILDE_DIR;
    };

    xdg.configFile."nix/registry.json".text =
      config.environment.etc."nix/registry.json".text;
  }];
}
