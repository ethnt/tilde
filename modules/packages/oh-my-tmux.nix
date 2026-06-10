{ stdenv, lib }:

stdenv.mkDerivation {
  pname = "oh-my-tmux";
  version = "2026-02-01";

  # fetchFromGitHub has trouble with the extracted directory from the ZIP file having a
  # preceding dot, so use fetchTarball instead
  src = fetchTarball {
    url =
      "https://github.com/gpakosz/.tmux/archive/af33f07134b76134acca9d01eacbdecca9c9cda6.tar.gz";
    sha256 = "sha256-nXm664l84YSwZeRM4Hsweqgz+OlpyfwXcgEdyNGhaGA=";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir $out
    cp -r ./.tmux.conf* $out

    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/gpakosz/.tmux";
    description =
      "Oh my tmux! My self-contained, pretty & versatile tmux configuration made with love";
    platforms = lib.platforms.all;
    license = lib.licenses.mit;
  };
}
