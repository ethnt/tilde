{ flake, ... }: {
  nixpkgs = {
    overlays = with flake; [
      overlays.default
      inputs.pragmatapro.overlays.default
      inputs.rippkgs.overlays.default
    ];
    config.allowUnfree = true;
  };

  nix = {
    gc.automatic = true;
    nixPath.nixpkgs = "flake:nixpkgs";
    settings.extra-experimental-features = [ "repl-flake" ];
  };
}
