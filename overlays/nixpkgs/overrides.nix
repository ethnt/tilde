channels: final: prev: {
  __dontExport = true;

  inherit (channels.nixpkgs-unstable)
    asdf-vm cachix comma difftastic nix tailscale vscode;
}
