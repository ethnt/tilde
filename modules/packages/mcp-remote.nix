{ stdenv, pnpm_10, fetchFromGitHub, fetchPnpmDeps, pnpmConfigHook, nodejs, bash
, lib }:

let pnpm = pnpm_10;
in stdenv.mkDerivation (finalAttrs: rec {
  pname = "mcp-remote";
  version = "0.1.38";

  src = fetchFromGitHub {
    owner = "geelen";
    repo = "mcp-remote";
    tag = "v${version}";
    hash = "sha256-+oNI2Uq7gW3sLzJS4ky2+BXhTmo44+WpcdYgieGPpmI=";
  };

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    inherit pnpm;
    fetcherVersion = 4;
    hash = "sha256-5podB1HJahhn2vlMBnu0wm7AJ0bjq8pvXqPgdR8c3GQ=";
  };

  nativeBuildInputs = [ nodejs pnpmConfigHook pnpm ];

  doCheck = true;

  strictDeps = true;

  buildPhase = ''
    runHook preBuild

    pnpm -C . exec tsc -p . --noEmit
    pnpm -C . build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    cp -r node_modules $out/
    cp -r dist $out/

    echo '#!${lib.getExe bash}' > $out/bin/mcp-remote

    echo "export NODE_PATH=$out/node_modules; ${nodejs}/bin/node $out/dist/proxy.js \"\$@\"" >> $out/bin/mcp-remote

    chmod +x $out/bin/mcp-remote

    runHook postInstall
  '';

  meta = {
    description =
      "Connect an MCP Client that only supports local (stdio) servers to a Remote MCP Server, with auth support:";
    homepage = "https://github.com/geelen/mcp-remote";
    license = lib.licenses.mit;
    mainProgram = "mcp-remote";
  };
})
