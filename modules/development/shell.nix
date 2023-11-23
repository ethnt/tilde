{ inputs, ... }: {
  imports = [ inputs.devenv.flakeModule ];

  perSystem = { pkgs, ... }: {
    devenv.shells.default = _:
      {
        packages = with pkgs; [ cachix git-crypt dhall just statix ];
      } // {
        containers = pkgs.lib.mkForce { };
      };
  };
}
