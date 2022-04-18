{ self, pkgs, inputs, ... }: {
  modules = { pkgs, ... }: { packages = with pkgs; [ cachix nixfmt statix ]; };
  exportedModules = [ ./tilde.toml ];
}
