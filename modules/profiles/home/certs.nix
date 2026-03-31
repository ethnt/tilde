{ pkgs, ... }: {
  home.sessionVariables = rec {
    SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    NIX_SSL_CERT_FILE = SSL_CERT_FILE;
  };
}
