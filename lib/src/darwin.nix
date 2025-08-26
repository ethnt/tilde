{ flake, withSystem, ... }:

let
  inherit (flake) inputs secrets homeConfigurations;

  l = inputs.nixpkgs.lib // builtins;

  sharedModules = (l.attrValues flake.darwinModules)
    ++ [ inputs.home-manager.darwinModules.home-manager ];

  specialArgs = {
    inherit flake inputs secrets homeConfigurations;
    suites = flake.suites.darwin;
    profiles = flake.profiles.darwin;
  };

  mkDarwinConfiguration = { system, configuration }:
    withSystem system ({ pkgs, ... }:
      inputs.nix-darwin.lib.darwinSystem {
        inherit pkgs system specialArgs;
        modules = sharedModules ++ [ configuration ];
      });
in { inherit mkDarwinConfiguration; }
