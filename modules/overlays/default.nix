{ inputs, ... }: {
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];

  perSystem = { system, ... }: {
    overlayAttrs = let
      nixpkgs-master = import inputs.nixpkgs-master {
        inherit system;

        config.allowUnfree = true;
      };
    in {
      nixpkgs-master-darwin-linux-builder = nixpkgs-master.darwin.linux-builder;
    };
  };
}
