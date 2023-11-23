{ flake, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { suites = flake.suites.home; };
  };
}
