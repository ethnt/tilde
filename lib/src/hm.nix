{ flake, withSystem, ... }:

let
  inherit (flake) inputs secrets;

  l = inputs.nixpkgs.lib // builtins;

  sharedModules = (l.attrValues flake.homeModules)
    ++ [ inputs.nixvim.homeManagerModules.nixvim ];

  extraSpecialArgs = {
    inherit flake inputs secrets;
    suites = flake.suites.home;
    profiles = flake.profiles.home;
  };

  mkHomeManagerConfiguration = { system, configuration }:
    withSystem system ({ pkgs, ... }:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = sharedModules ++ [ configuration ];
      });

in { inherit sharedModules extraSpecialArgs mkHomeManagerConfiguration; }
