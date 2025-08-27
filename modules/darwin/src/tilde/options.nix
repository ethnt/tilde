{ lib, ... }:

with lib;

{
  options.tilde.host = {
    directory = mkOption {
      type = types.str;
      description = "Location of Tilde in the system";
    };
  };
}
