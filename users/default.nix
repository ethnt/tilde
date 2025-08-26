{ self, ... }:
let inherit (self.lib.hm) mkHomeManagerConfiguration;
in {
  flake.homeConfigurations = {
    ethan = mkHomeManagerConfiguration {
      username = "ethan";
      system = "aarch64-darwin";
      configuration = ./ethan/home.nix;
    };

    et = mkHomeManagerConfiguration {
      username = "et";
      system = "aarch64-darwin";
      configuration = ./et/home.nix;
    };
  };
}
