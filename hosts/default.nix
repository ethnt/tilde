{ self, withSystem, ... }:
let
  inherit (self) inputs darwinModules_ homeConfigurations;
  inherit (inputs) haumea nix-darwin home-manager;
  l = inputs.nixpkgs.lib // builtins;

  homeProfiles = haumea.lib.load {
    src = ../modules/profiles/home;
    loader = haumea.lib.loaders.path;
  };

  homeSuites = import ../modules/suites/home.nix { profiles = homeProfiles; };

  commonModules = [ home-manager.darwinModules.home-manager ]
    ++ (l.attrValues darwinModules_);

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
        specialArgs = { inherit inputs profiles suites homeConfigurations; };
      in nix-darwin.lib.darwinSystem { inherit system modules specialArgs; });
in {
  flake.darwinConfigurations = {
    eMac = mkHost "eMac" {
      system = "aarch64-darwin";
      user = "ethan";
    };
  };
}
