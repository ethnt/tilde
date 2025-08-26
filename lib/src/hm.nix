{ flake, withSystem, ... }:

let
  l = flake.inputs.nixpkgs.lib // builtins;

  sharedModules = (l.attrValues flake.homeModules)
    ++ [ flake.inputs.nixvim.homeManagerModules.nixvim ];

  extraSpecialArgs = {
    inherit flake;
    inherit (flake) inputs secrets;
    suites = flake.suites.home;
    profiles = flake.profiles.home;
  };

  mkHomeManagerConfiguration = { system, configuration }:
    withSystem system ({ pkgs, ... }:
      (flake.inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = sharedModules ++ [ configuration ];
      }));

in { inherit sharedModules extraSpecialArgs mkHomeManagerConfiguration; }
