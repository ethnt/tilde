{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  name = "nix-docker";

  src = fetchFromGitHub {
    owner = "LnL7";
    repo = "nix-docker";
    rev = "277b1ad6b6d540e4f5979536eff65366246d4582";
    sha256 = "F8QizIR9A1Axt0C+NQHxDkNEMtRKALgLxuqfqXMAMgM=";
  };

  installPhase = ''
    mkdir -p $out
    cp -a * $out/
    chmod 0400 $out/ssh/insecure_rsa
  '';

  meta = with lib; {
    homepage = "https://github.com/LnL7/nix-docker";
    description = "Docker images for the Nix package manager";
    platforms = platforms.all;
    licence = licences.mit;
  };
}
