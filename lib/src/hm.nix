{ flake, withSystem, ... }:

let
  l = flake.inputs.nixpkgs.lib // builtins;

  sharedModules = (l.attrValues flake.homeModules) ++ [
    flake.inputs.nixvim.homeManagerModules.nixvim
    {
      home.sessionVariables = {
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_STATE_HOME = "$HOME/.local/state";
      };
    }
  ];

  extraSpecialArgs = {
    inherit (flake) inputs secrets;
    suites = flake.suites.home;
    profiles = flake.profiles.home;
  };

  mkHomeManagerConfiguration = { system, configuration }:
    withSystem system ({ pkgs, ... }:
      (flake.inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = sharedModules ++ [ configuration ];
        inherit extraSpecialArgs;
      }));

in { inherit sharedModules extraSpecialArgs mkHomeManagerConfiguration; }
