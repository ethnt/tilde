channels: final: prev: {
  inherit (channels.nixpkgs-unstable) difftastic;
  inherit (channels.nixpkgs-master) cachix;
}
