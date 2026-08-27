{ stdenv
, pnpm_10
, fetchFromGitHub
, fetchPnpmDeps
, pnpmConfigHook
, nodejs
, makeWrapper
, lib
, nix-update-script
,
}:

let
  pnpm = pnpm_10;
in
stdenv.mkDerivation (finalAttrs: rec {
  pname = "mcp-remote";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "geelen";
    repo = "mcp-remote";
    tag = "v${version}";
    hash = "sha256-xloxs1RimInxuIn5YSr6IKic+KqBt9TTf2w7cVniRVE=";
  };

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    inherit pnpm;
    fetcherVersion = 4;
    hash = "sha256-ABYIv8gLyTO9Na2vPvKf4iMvQgQ2ExZfClslV7hXu+o=";
  };

  nativeBuildInputs = [
    nodejs
    pnpmConfigHook
    pnpm
    makeWrapper
  ];

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

    cp -r {node_modules,dist} $out/

    makeWrapper "${lib.getExe nodejs}" "$out/bin/mcp-remote" \
      --set NODE_PATH "$out/node_modules" \
      --add-flags "$out/dist/proxy.js"

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Connect an MCP Client that only supports local (stdio) servers to a Remote MCP Server, with auth support";
    homepage = "https://github.com/geelen/mcp-remote";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
    mainProgram = "mcp-remote";
  };
})
