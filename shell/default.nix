{ self, inputs, ... }: {
  modules = with inputs; [ ];
  exportedModules = [ ./tilde.nix ];
}
