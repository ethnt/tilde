{ pkgs, ... }: {
  programs.starship = {
    enable = true;
    package = pkgs.starship.overrideAttrs (attrs: rec {
      version = "1.17.1";

      src = pkgs.fetchFromGitHub {
        owner = "starship";
        repo = "starship";
        rev = "v${version}";
        hash = "sha256-e+vhisUzSYKUUoYfSaQwpfMz2OzNcZbeHgbvyPon18g=";
      };

      cargoDeps = attrs.cargoDeps.overrideAttrs (pkgs.lib.const {
        inherit src;
        name = "starship-vendor.tar.gz";
        outputHash = "sha256-JAdYrdM11a1gquqL1ijjaEdMNYWHMWT5HI8+6eym+do=";
      });

      cargoHash = "sha256-xLlZyLvS9AcXQHxjyL4Dden1rEwCLB8/comfRyqXXCI=";
    });
    enableFishIntegration = true;
    settings = { character = { success_symbol = "[➜](bold green)"; }; };
  };
}
