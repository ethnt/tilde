channels: final: prev: {
  __dontExport = true;

  inherit (channels.nixpkgs-unstable) difftastic;
  inherit (channels.nixpkgs-master) cachix;
}
