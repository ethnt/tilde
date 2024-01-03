{ stdenv, lib }:

stdenv.mkDerivation {
  name = "oh-my-tmux";

  # fetchFromGitHub has trouble with the extracted directory from the ZIP file having a
  # preceding dot, so use fetchTarball instead
  src = builtins.fetchTarball {
    url =
      "https://github.com/gpakosz/.tmux/archive/dd9502a09a9d5a4c97c271670e7ca7cb2171ab7f.tar.gz";
    sha256 = "1802dgqg7fpd60c5awdizbwj5lfpn19qgxiwb089pfpj88q8ixnz";
  };

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir $out
    cp -r ./.tmux.conf* $out
  '';

  meta = with lib; {
    homepage = "https://github.com/gpakosz/.tmux";
    description =
      "Oh my tmux! My self-contained, pretty & versatile tmux configuration made with love";
    platforms = platforms.all;
    licence = licences.mit;
  };
}
