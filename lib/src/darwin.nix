{ flake, withSystem, ... }:

let
  l = flake.inputs.nixpkgs.lib // builtins;

  sharedModules = (l.attrValues flake.darwinModules)
    ++ [ flake.inputs.home-manager.darwinModules.home-manager ];

  specialArgs = {
    inherit flake;
    inherit (flake) inputs secrets homeConfigurations;
    suites = flake.suites.darwin;
    profiles = flake.profiles.darwin;
  };

  mkDarwinConfiguration = { system, configuration }:
    withSystem system ({ pkgs, ... }:
      flake.inputs.nix-darwin.lib.darwinSystem {
        inherit pkgs system specialArgs;
        modules = sharedModules ++ [ configuration ];
      });
in { inherit mkDarwinConfiguration; }
