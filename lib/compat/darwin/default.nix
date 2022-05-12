_:
let
  inherit (default.inputs.nixpkgs) lib;

  default = (import ../.).defaultNix;
  configs = default.darwinConfigurations;
  host = configs.${hostname};
  hostname = builtins.getEnv "HOSTNAME";
in host
