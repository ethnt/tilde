{ flake, ... }: {
  home-manager = {
    inherit (flake.lib.hm) sharedModules extraSpecialArgs;

    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
  };
}
