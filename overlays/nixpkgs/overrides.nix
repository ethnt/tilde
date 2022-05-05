channels: final: prev: {
  __dontExport = true;

  inherit (channels.nixpkgs-unstable) asdf-vm comma difftastic nix nushell;
  inherit (channels.nixpkgs-master) cachix;
}
