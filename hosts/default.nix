{ self, withSystem, ... }:
let
  inherit (self) inputs darwinModules;
  inherit (inputs) haumea nix-darwin home-manager;
  inherit (self.lib.utils) flattenTree;
  l = inputs.nixpkgs.lib // builtins;

  commonModules = [ home-manager.darwinModules.home-manager ] ++ darwinModules;

  profiles = haumea.lib.load {
    src = ../modules/profiles/system;
    loader = haumea.lib.loaders.path;
  };

  suites = import ../modules/suites/system.nix { inherit profiles; };

  mkHost = hostname:
    { system, configuration ? ./${hostname}/configuration.nix, ... }:
    withSystem system ({ pkgs, ... }:
      let
        nixpkgsConfiguration = _: { nixpkgs = { inherit pkgs; }; };
        modules = commonModules ++ [ nixpkgsConfiguration configuration ];
        specialArgs = { inherit inputs profiles suites; };
      in nix-darwin.lib.darwinSystem { inherit system modules specialArgs; });
in {
  flake.darwinConfigurations = {
    eMac = mkHost "eMac" {
      system = "x86_64-darwin";
      user = "ethan";
    };
  };
}
