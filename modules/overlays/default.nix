{ inputs, ... }: {
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];

  perSystem = { system, ... }: {
    overlayAttrs = let
      nixpkgs-master = import inputs.nixpkgs-master {
        inherit system;

        config.allowUnfree = true;
      };
    in { inherit (nixpkgs-master) claude-code; };
  };
}
