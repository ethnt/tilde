{ self, pkgs, inputs, ... }: {
  modules = { pkgs, ... }: { packages = with pkgs; [ cachix git-crypt nixfmt statix ]; };
  exportedModules = [ ./tilde.toml ];
}
