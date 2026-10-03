{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "aictl";
  version = "0.47.18";

  src = fetchFromGitHub {
    owner = "pwittchen";
    repo = "aictl";
    tag = "v${version}";
    hash = "sha256-FogboTX81IKYjKMYrh1bYUD6DhAKWHR0C1Um6XQIFeU=";
  };

  cargoHash = "sha256-S1OOl0XuTEo93tTpZZ5tosRLM9wBwW6jbInmAsscPGw";

  checkFlags = [ "--skip=tools::list_processes::tests::tool_lists_current_process" ];

  meta = {
    description = "Native AI agent for your terminal and macOS desktop";
    homepage = "https://github.com/pwittchen/aictl";
    license = "polyform";
    platforms = lib.platforms.all;
    mainProgram = "aictl";
  };
}
