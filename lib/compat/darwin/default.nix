_:
let
  default = (import ../.).defaultNix;
  configs = default.darwinConfigurations;
  host = configs.${hostname};
  hostname = builtins.getEnv "HOSTNAME";
in host
