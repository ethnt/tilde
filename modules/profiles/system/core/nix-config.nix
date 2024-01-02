{
  nixpkgs.config.allowUnfree = true;

  nix = {
    gc.automatic = true;
    nixPath.nixpkgs = "flake:nixpkgs";
    settings = {
      auto-optimise-store = true;
      extra-experimental-features = [ "repl-flake" ];
    };
  };
}
