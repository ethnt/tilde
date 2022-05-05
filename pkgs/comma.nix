{ fetchFromGitHub, lib, pkgs, naersk }:

let naersk-lib = pkgs.callPackage naersk { };
in naersk-lib.buildPackage {
  pname = "comma";
  src = fetchFromGitHub {
    owner = "nix-community";
    repo = "comma";
    rev = "v1.2.3";
    sha256 = "emhvBaicLAnu/Kn4oxHngGa5BSxOEwbkhTLO5XvauMw=";
  };
  nativeBuildInputs = with pkgs; [ makeWrapper ];
  overrideMain = _: {
    postInstall = ''
      wrapProgram $out/bin/comma \
        --prefix PATH : ${
          lib.makeBinPath (with pkgs; [ nix fzy nix-index-unwrapped ])
        }
      ln -s $out/bin/comma $out/bin/,
    '';
  };
}
