{ lib
, stdenv
, fetchFromGitHub
, nodejs
, pnpm_10
, fetchPnpmDeps
, pnpmConfigHook
, makeWrapper
, nix-update-script
,
}:

stdenv.mkDerivation rec {
  pname = "transcend-consent-mcp";
  version = "@transcend-io/privacy-types@6.7.0";

  src = fetchFromGitHub {
    owner = "transcend-io";
    repo = "tools";
    tag = "@transcend-io/mcp-server-consent@${version}";
    hash = "sha256-eHzqW2rChQeRp8eu4fCXvkNyTA6ekotQWLeJgvjNc9U=";
  };

  pnpmWorkspaces = [ "@transcend-io/mcp-server-consent..." ];

  pnpmDeps = fetchPnpmDeps {
    inherit pname version src pnpmWorkspaces;
    pnpm = pnpm_10;
    fetcherVersion = 4;
    hash = "sha256-P3ruuJDgxE2vJuz9Pe1rlLUqU6VIKwwNxhGxQngygKE=";
  };

  nativeBuildInputs = [
    nodejs
    pnpm_10
    pnpmConfigHook
    makeWrapper
  ];

  buildPhase = ''
    runHook preBuild

    pnpm --filter="@transcend-io/mcp-server-consent..." build

    pnpm --filter="@transcend-io/mcp-server-consent" exec \
      tsdown src/cli.ts \
      --deps.alwaysBundle '/.*/' \
      --no-dts --no-sourcemap --no-clean \
      --out-dir "$NIX_BUILD_TOP/dist-standalone"

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -Dm755 "$NIX_BUILD_TOP/dist-standalone/cli.mjs" \
      "$out/lib/transcend-consent-mcp/cli.mjs"

    makeWrapper ${lib.getExe nodejs} "$out/bin/transcend-mcp-consent" \
      --add-flags "$out/lib/transcend-consent-mcp/cli.mjs"

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version-regex" "@transcend-io/mcp-server-consent@(.*)" ];
  };

  meta = {
    description = "Transcend MCP server for consent management";
    homepage = "https://github.com/transcend-io/tools/tree/main/packages/mcp/mcp-server-consent";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
    mainProgram = "transcend-mcp-consent";
  };
}
