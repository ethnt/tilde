{ inputs, ... }: {
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];

  perSystem = { system, ... }: {
    overlayAttrs =
      let
        nixpkgsConfig = {
          inherit system;
          config.allowUnfree = true;
        };

        nixpkgs-master = import inputs.nixpkgs-master nixpkgsConfig;
      in
      {
        inherit (nixpkgs-master) ghostty-bin;
      };
  };
}
