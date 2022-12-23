channels: final: prev: {
  __dontExport = true;

  inherit (channels.nixpkgs-unstable)
    asdf-vm cachix comma difftastic manix nix nushell tailscale vscode;
  inherit (channels.nixpkgs-22_05) hub;

  vscode-pinned = channels.nixpkgs-vscode-pin.vscode;
}
