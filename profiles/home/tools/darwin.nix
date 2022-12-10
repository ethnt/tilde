{ pkgs, lib, ... }: {
  home.packages = with pkgs; (lib.optionals (stdenv.isDarwin) [ mas ]);
}
