{ flake, ... }: {
  nixpkgs = {
    overlays = with flake; [
      overlays.default
      inputs.pragmatapro.overlays.default
      inputs.rippkgs.overlays.default
    ];
    config.allowUnfree = true;
    flake = {
      setFlakeRegistry = true;
      setNixPath = true;
    };
  };

  nix = { gc.automatic = true; };
}
