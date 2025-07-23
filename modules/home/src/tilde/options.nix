{ config, lib, ... }:

with lib;

let cfg = config.tilde.home;
in {
  options.tilde.home = {
    username = mkOption { type = types.str; };

    homeDirectory = mkOption {
      type = types.str;
      default = "/Users/${cfg.username}";
    };

    gpg = mkOption {
      type = types.submodule {
        options = {
          keyId = mkOption {
            type = types.nullOr types.str;
            default = null;
          };
        };
      };
      default = { };
    };
  };

  # Sometimes a "conflicting definition values" error pops up in an `<unknown-file>` for the `homeDirectory` option,
  # so we need to add `mkForce`
  config = {
    home = {
      username = mkForce cfg.username;
      homeDirectory = mkForce cfg.homeDirectory;
    };
  };
}
