{ pkgs, lib, ... }: {
  home.packages = with pkgs; (lib.optionals stdenv.isDarwin [ cacert mas ]);
}
