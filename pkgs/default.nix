{ inputs, ... }:

_final: prev: {
  pragmatapro = inputs.pragmatapro.packages.${prev.system}.default;
  sf-pro = prev.callPackage ./fonts/sf-pro.nix { };
  nix-docker = prev.callPackage ./nix-docker.nix { };
  oh-my-tmux = prev.callPackage ./oh-my-tmux.nix { };
}
