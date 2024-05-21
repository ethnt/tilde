{ stdenv, lib }:

stdenv.mkDerivation {
  name = "oh-my-tmux";

  # fetchFromGitHub has trouble with the extracted directory from the ZIP file having a
  # preceding dot, so use fetchTarball instead
  src = builtins.fetchTarball {
    url =
      "https://github.com/gpakosz/.tmux/archive/9cf49731cd785b76cf792046feed0e8275457918.tar.gz";
    sha256 = "0y1n8cspqz79arzw4mnfxrl0b5ydk98pzq2pwn2xfkbylpg61fzv";
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
