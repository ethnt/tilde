{ stdenv, lib }:

stdenv.mkDerivation {
  pname = "oh-my-tmux";
  version = "2026-08-08";

  # fetchFromGitHub has trouble with the extracted directory from the ZIP file having a
  # preceding dot, so use fetchTarball instead
  src = fetchTarball {
    url = "https://github.com/gpakosz/.tmux/archive/58a3dcc0d718ec0fa1c0d5a2fddd640a1ad7a5b7.tar.gz";
    sha256 = "sha256-YDzbZVFhrAMBhOI8HVDxR3rEPkrEwG57IUbnZicmfn4=";
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
    description = "Oh my tmux! My self-contained, pretty & versatile tmux configuration made with love";
    platforms = lib.platforms.all;
    license = lib.licenses.mit;
  };
}
