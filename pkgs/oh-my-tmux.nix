{ stdenv, lib }:

stdenv.mkDerivation {
  name = "oh-my-tmux";

  # fetchFromGitHub has trouble with the extracted directory from the ZIP file having a
  # preceding dot, so use fetchTarball instead
  src = builtins.fetchTarball {
    url =
      "https://github.com/gpakosz/.tmux/archive/9a2387c0c7aa8d12cff06d6be17251e8ebdfd034.tar.gz";
    sha256 = "0jwlw19nhlw2xn7rmh4gfnwshia9s37i0l0537yh6fnkv6zdhikf";
  };

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir $out
    cp -r ./ $out
  '';

  meta = with lib; {
    homepage = "https://github.com/gpakosz/.tmux";
    description =
      "Oh my tmux! My self-contained, pretty & versatile tmux configuration made with love";
    platforms = platforms.all;
    licence = licences.mit;
  };
}
