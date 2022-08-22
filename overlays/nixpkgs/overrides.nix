channels: final: prev: {
  __dontExport = true;

  inherit (channels.nixpkgs-unstable)
    asdf-vm comma difftastic nix nushell tailscale;
  inherit (channels.nixpkgs-master) cachix;

  vscode-1_66_1 = channels.nixpkgs-vscode-pin.vscode;
}
