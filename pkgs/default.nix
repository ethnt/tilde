_final: prev: {
  pragmatapro = prev.callPackage ./fonts/pragmatapro.nix { };
  sf-pro = prev.callPackage ./fonts/sf-pro.nix { };
  nix-docker = prev.callPackage ./nix-docker.nix { };
  oh-my-tmux = prev.callPackage ./oh-my-tmux.nix { };
  starship = prev.starship.overrideAttrs (oldAttrs: rec {
    version = "1.17.1";

    src = prev.fetchFromGitHub {
      owner = "starship";
      repo = "starship";
      rev = "v${version}";
      hash = "sha256-e+vhisUzSYKUUoYfSaQwpfMz2OzNcZbeHgbvyPon18g=";
    };

    cargoDeps = oldAttrs.cargoDeps.overrideAttrs (prev.lib.const {
      name = "starship-vendor.tar.gz";
      inherit src;
      outputHash = "sha256-JAdYrdM11a1gquqL1ijjaEdMNYWHMWT5HI8+6eym+do=";
    });

    cargoHash = "sha256-xLlZyLvS9AcXQHxjyL4Dden1rEwCLB8/comfRyqXXCI=";
  });
}
