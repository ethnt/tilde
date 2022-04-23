channels: final: prev: {
  __dontExport = true;

  inherit (channels.nixpkgs-unstable) asdf-vm difftastic nix nushell;
  inherit (channels.nixpkgs-master) cachix;
}
