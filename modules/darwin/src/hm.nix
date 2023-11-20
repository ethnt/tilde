# { haumea, ... }:
# let
#   # inherit (flake) inputs;
#   # inherit (inputs) haumea;

#   # hm = inputs.home-manager;

#   profiles = haumea.lib.load {
#     src = ../../profiles/home;
#     loader = haumea.lib.loaders.path;
#   };

#   suites = import ../../suites/home.nix { inherit profiles; };
#   #   imports = [hm.darwinModules.home-manager];

#   #   home-manager = {
#   #     useGlobalPkgs = true;
#   #     useUserPackages = true;
#   #     extraSpecialArgs = {
#   #       inherit (flake) inputs;
#   #       inherit profiles suites;
#   #     };
#   #   };
#   # }
# in {
#   home-manager.useGlobalPkgs = true;
#   home-manager.useUserPackages = true;
#   home-manager.extraSpecialArgs = { inherit suites profiles; };
# }
{ }
