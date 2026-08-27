{ lib
, buildNpmPackage
, fetchFromGitHub
, nix-update-script
,
}:

buildNpmPackage (finalAttrs: {
  pname = "firehydrant-mcp";
  version = "0.0.4";

  src = fetchFromGitHub {
    owner = "firehydrant";
    repo = "firehydrant-mcp";
    tag = "v${finalAttrs.version}";
    hash = "sha256-mVsKKah5REjcOz9is1AxzduRNL75+YHYaTBRPvn5cf8=";
  };

  npmDepsHash = "sha256-IxHcnPrXrCDcZW695D5u4fIz65L4MSKl4t8V27pdu7k=";

  npmPackFlags = [ "--ignore-scripts" ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Official FireHydrant MCP server";
    homepage = "https://github.com/firehydrant/firehydrant-mcp";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
    mainProgram = "firehydrant-mcp";
  };
})
