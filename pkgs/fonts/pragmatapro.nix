{ stdenv, lib }:

stdenv.mkDerivation rec {
  name = "pragmatapro";
  version = "0829";

  src = builtins.fetchGit {
    url = "https://github.com/ethnt/pragmatapro.git";
    ref = "master";
    rev = "318cc2f113653fc93e907ad3ca1a1ca893604f24";
  };

  phases = [ "unpackPhase" "installPhase" ];
  pathsToLink = [ "/share/fonts/opentype/" ];
  sourceRoot = ".";
  installPhase = ''
    install_path=$out/share/fonts/opentype
    mkdir -p $install_path
    find -name "PragmataPro*${version}*.otf" -exec cp {} $install_path \;
  '';

  meta = with lib; {
    homepage = "https://www.fsd.it/shop/fonts/pragmatapro/";
    description = ''
      PragmataPro™ is a condensed monospaced font optimized for screen,
      designed by Fabrizio Schiavi to be the ideal font for coding, math and engineering
    '';
    platforms = platforms.all;
    licence = licences.unfree;
  };
}
