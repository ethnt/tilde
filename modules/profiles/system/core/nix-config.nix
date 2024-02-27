{
  nixpkgs.config.allowUnfree = true;

  nix = {
    gc.automatic = true;
    nixPath.nixpkgs = "flake:nixpkgs";
    settings.extra-experimental-features = [ "repl-flake" ];
  };
}
