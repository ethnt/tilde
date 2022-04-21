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
        options = { keyId = mkOption { type = types.str; }; };
      };
    };
  };

  config = { home = { inherit (cfg) username homeDirectory; }; };
}
