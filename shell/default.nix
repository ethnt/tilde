{ self, inputs, ... }: {
  modules = with inputs; [ bud.devshellModules.bud ];
  exportedModules = [ ./tilde.nix ];
}
