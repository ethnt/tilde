{ config, lib, ... }:

with lib;

{
  options.tilde.system = { name = mkOption { type = types.str; }; };
}
