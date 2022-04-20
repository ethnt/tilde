{
  programs.git = {
    enable = true;

    aliases = { "s" = "status"; };
    ignores = [ "*~" "#*#" ".elc" ".#*" "flycheck_*.el" ".projectile" ];

    delta.enable = true;

    signing.signByDefault = true;

    extraConfig = {
      http = {
        sslCAinfo = "/etc/ssl/certs/ca-certificates.crt";
      };
    };
  };
}
