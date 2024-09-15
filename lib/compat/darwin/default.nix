_:
let
  default = (import ../.).defaultNix;
  configs = default.darwinConfigurations;
  host = configs.${hostname} or configs.eMac;
  hostname = builtins.getEnv "HOSTNAME";
in host
