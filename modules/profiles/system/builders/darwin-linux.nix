{ pkgs, ... }: {
  nix.linux-builder = {
    enable = true;
    package = pkgs.nixpkgs-master-darwin-linux-builder;
  };
}
