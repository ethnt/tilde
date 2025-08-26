{ flake, pkgs, ... }: {
  nixpkgs = {
    # NOTE: This relies on all hosts having the same `system`. If a system comes along that is different, this cannot
    # be set to the flake-wide `pkgs`, as it is here: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-nixpkgs.pkgs
    inherit pkgs;

    flake = {
      setFlakeRegistry = true;
      setNixPath = true;
    };
  };

  nix.gc.automatic = true;
}
