{ self, ... }:
let inherit (self.lib.hm) mkHomeManagerConfiguration;
in {
  flake.homeConfigurations = {
    ethan = mkHomeManagerConfiguration {
      system = "aarch64-darwin";
      configuration = ./ethan/home.nix;
    };

    et = mkHomeManagerConfiguration {
      system = "aarch64-darwin";
      configuration = ./et/home.nix;
    };
  };
}
