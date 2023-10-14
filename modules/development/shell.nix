{ inputs, ... }: {
  imports = [ inputs.devenv.flakeModule ];

  perSystem = { pkgs, ... }: {
    devenv.shells.default = _:
      {
        packages = with pkgs; [ git-crypt dhall just statix ];
      } // {
        containers = pkgs.lib.mkForce { };
      };
  };
}
