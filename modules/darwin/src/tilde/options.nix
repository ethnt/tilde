{ config, lib, ... }:

with lib;

{
  options.tilde.host = {
    name = mkOption {
      type = types.str;
      description = "The hostname for the system";
    };

    system = mkOption {
      type = types.str;
      description = "System of the host";
      example = "x86_64-darwin";
    };

    directory = mkOption {
      type = types.str;
      description = "Location of Tilde in the system";
    };

    primaryUser = mkOption {
      type = types.submodule {
        options = {
          username = mkOption {
            type = types.str;
            description = "Username of the primary user of the system";
          };

          homeDirectory = mkOption {
            type = types.str;
            description = "Home directory of the primary user";
            default = "/Users/${config.tilde.host.primaryUser.username}";
          };
        };
      };
    };
  };
}
