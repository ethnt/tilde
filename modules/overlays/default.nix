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
        nixpkgs-unstable = import inputs.nixpkgs-unstable nixpkgsConfig;
      in
      {
        inherit (nixpkgs-master) ghostty-bin;
        inherit (nixpkgs-unstable) zed-editor;
      };
  };
}
