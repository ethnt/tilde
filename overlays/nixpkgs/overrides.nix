channels: final: prev: {
  __dontExport = true;

  inherit (channels.nixpkgs-unstable)
    asdf-vm cachix comma difftastic manix nix nushell tailscale vscode;

  vscode-pinned = channels.nixpkgs-vscode-pin.vscode;
}
