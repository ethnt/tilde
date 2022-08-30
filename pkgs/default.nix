final: prev:
let sources = prev.callPackage ./vscode/_sources/generated.nix { };
in {
  pragmatapro = prev.callPackage ./fonts/pragmatapro.nix { };
  sf-pro = prev.callPackage ./fonts/sf-pro.nix { };
  nix-docker = prev.callPackage ./nix-docker.nix { };
  oh-my-tmux = prev.callPackage ./oh-my-tmux.nix { };
  vscode-ext = final.vscode-extensions-builder sources {

  };
}
