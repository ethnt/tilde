{ flake, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit (flake) inputs secrets;
      suites = flake.suites.home;
      profiles = flake.profiles.home;
    };
  };

  # These are shared modules because they require configuration from the system, not the home configuration
  home-manager.sharedModules = [{
    home.sessionVariables = {
      # environment.sessionVariables is not currently available in nix-darwin
      # NIX_PATH =
      #   config.environment.sessionVariables.NIX_PATH or config.environment.variables.NIX_PATH;

      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
    };

    # xdg.configFile."nix/registry.json".text =
    #   config.environment.etc."nix/registry.json".text;
  }];
}
