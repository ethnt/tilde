channels: final: prev: {
  __dontExport = true;

  inherit (channels.nixpkgs-unstable)
    asdf-vm comma difftastic manix nix nushell tailscale vscode;
  inherit (channels.nixpkgs-master) cachix;

  vscode-pinned = channels.nixpkgs-vscode-pin.vscode;
}
