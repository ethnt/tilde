{ self, ... }:
let inherit (self.lib.darwin) mkDarwinConfiguration;
in {
  flake.darwinConfigurations = {
    eMac = mkDarwinConfiguration {
      system = "aarch64-darwin";
      configuration = ./eMac/configuration.nix;
    };

    mercury = mkDarwinConfiguration {
      system = "aarch64-darwin";
      configuration = ./mercury/configuration.nix;
    };
  };
}
