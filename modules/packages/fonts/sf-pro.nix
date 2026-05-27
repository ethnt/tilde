{ stdenv, lib, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "sf-pro";

  src = fetchFromGitHub {
    owner = "sahibjotsaggu";
    repo = "San-Francisco-Pro-Fonts";
    rev = "8bfea09aa6f1139479f80358b2e1e5c6dc991a58";
    hash = "sha256-mAXExj8n8gFHq19HfGy4UOJYKVGPYgarGd/04kUIqX4=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 *.otf -t "$out/share/fonts/opentype/"
    install -Dm644 *.ttf -t "$out/share/fonts/truetype/"

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://developer.apple.com/fonts/";
    description = ''
      This neutral, flexible, sans-serif typeface is the system font for iOS,
      iPad OS, macOS and tvOS. SF Pro features nine weights, variable optical
      sizes for optimal legibility, and includes a rounded variant. SF Pro
      supports over 150 languages across Latin, Greek, and Cyrillic scripts.
    '';
    platforms = platforms.all;
    licence = licences.unfree;
  };
}
