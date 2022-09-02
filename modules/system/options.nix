{ config, lib, ... }:
with lib; {
  options.tilde.system = {
    name = mkOption { type = types.str; };
    directory = mkOption { type = types.str; };
    username = mkOption { type = types.str; };
    homeDirectory = mkOption { type = types.str; };
    user = mkOption { type = types.attrs; };
  };
}
