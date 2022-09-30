{ lib, stdenv, fetchFromGitHub, buildDotnetPackage, dotnetPackages, pkg-config
}:

buildDotnetPackage rec {
  pname = "dug";
  baseName = pname;
  version = "0.0.86";

  src = fetchFromGitHub {
    owner = "unfrl";
    repo = pname;
    rev = "${version}";
    sha256 = "gJ5w79IN+Ggz2119jOxN5b4b9PKhnavCaxD2vCjv2fo=";
  };

  projectFile = [ "cli/dug.csproj" ];

  propagatedBuildInputs = [ ];
  buildInputs = [];
  nativeBuildInputs = [ pkg-config ];

  meta = with lib; {
    homepage = "https://github.com/unfrl/dug";
    description = "A global DNS propagation checker that gives pretty output.";
    license = licenses.mit;
  };
}
