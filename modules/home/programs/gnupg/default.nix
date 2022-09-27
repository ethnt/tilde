{ config, lib, pkgs, ... }:

with lib;

let cfg = config.programs.gpg;
in {
  options.programs.gpg = {
    pinentryPath = mkOption {
      type = types.str;
      default = "/usr/local/bin/pinentry-mac";
    };
  };

  config = mkIf cfg.enable {
    home.file.".gnupg/gpg-agent.conf".text = ''
      enable-ssh-support
      ttyname $GPG_TTY
      default-cache-ttl 60
      max-cache-ttl 120
      pinentry-program ${cfg.pinentryPath}
    '';
  };
}
