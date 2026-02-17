{ stdenv, lib }:

stdenv.mkDerivation {
  name = "oh-my-tmux";

  # fetchFromGitHub has trouble with the extracted directory from the ZIP file having a
  # preceding dot, so use fetchTarball instead
  src = builtins.fetchTarball {
    url =
      "https://github.com/gpakosz/.tmux/archive/87dcd13a28aeb5f18baee630e24b3f5765ae3a4f.tar.gz";
    sha256 = "sha256-rfJkL4EMMunbC7wGiw7O/1E/0XTzA2N+RR7gXEoalAY=";
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
