{ stdenv, lib }:

stdenv.mkDerivation {
  name = "oh-my-tmux";

  # fetchFromGitHub has trouble with the extracted directory from the ZIP file having a
  # preceding dot, so use fetchTarball instead
  src = builtins.fetchTarball {
    url =
      "https://github.com/gpakosz/.tmux/archive/1ef77d21420ca3d849714e46b625e2bdb1f53b94.tar.gz";
    sha256 = "1vdyr305v4y22jdhpxk6lz7206rxlvg2vysqf80pb7jcnbfymjz0";
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
