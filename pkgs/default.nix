{ inputs }:

final: prev: {
  # TODO: This installs oh-my-tmux from a flake. Should it be a package instead?
  inherit (inputs) oh-my-tmux;

  pragmatapro = prev.callPackage ./fonts/pragmatapro.nix { };
  sf-pro = prev.callPackage ./fonts/sf-pro.nix { };
  nix-docker = prev.callPackage ./nix-docker.nix { };
}
