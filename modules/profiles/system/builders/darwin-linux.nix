\{
  nix.linux-builder = {
    enable = true;
    modules = [({ boot.binfmt.emulatedSystems = [ "x86_64-linux" ]; })];
  };
}
