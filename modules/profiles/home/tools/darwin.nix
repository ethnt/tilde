{ pkgs, lib, ... }: {
  home.packages =
    with pkgs;
    (lib.optionals stdenv.hostPlatform.isDarwin [
      cacert
      mas
    ]);
}
