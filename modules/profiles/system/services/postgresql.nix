{ pkgs, ... }: {
  # services.postgresql.enable = true;

  system.activationScripts.preActivation = {
    enable = true;
    text = ''
      if [ ! -d "/var/lib/postgresql/" ]; then
        echo "creating PostgreSQL data directory..."
        sudo mkdir -m 750 -p /var/lib/postgresql/
        chown -R ethan:staff /var/lib/postgresql/
      fi
    '';
  };

  services.postgresql.initdbArgs = [
    "-U ethan"
    "--pgdata=/var/lib/postgresql/15"
    "--auth=trust"
    "--no-locale"
    "--encoding=UTF8"
  ];
  services.postgresql.package = pkgs.postgresql_15;
  services.postgresql.enable = true;

  launchd.user.agents.postgresql.serviceConfig = {
    StandardErrorPath = "/tmp/postgres.error.log";
    StandardOutPath = "/tmp/postgres.log";
  };
}
