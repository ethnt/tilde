{ lib, fetchFromGitHub, buildGoModule, }:
let version = "0.0.1";
in buildGoModule {
  pname = "gh-stack";
  inherit version;

  src = fetchFromGitHub {
    owner = "github";
    repo = "gh-stack";
    tag = "v${version}";
    hash = "sha256-om7ekHez08X1YjP0W+3p0PxmjU/za6+/gHX5GPakKAw=";
  };

  vendorHash = "sha256-s85Lz6yfY1TiIFPolU1qESDyw8XoBORyuOMdiHj6Grc=";

  meta = {
    homepage = "https://github.com/github/gh-stack";
    description = "GitHub Stacked PRs";
    license = lib.licenses.mit;
    mainProgram = "gh-stack";
  };
}
