{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation {
  pname = "i-have-adhd";
  version = "2026-09-10";

  src = fetchFromGitHub {
    owner = "ayghri";
    repo = "i-have-adhd";
    rev = "7b9069b39972e269e61bd95c2f66ebb90cac6a02";
    hash = "sha256-UcOFEhcSq5E9gzFjVVd53nfn7RLWRwiXc+U35Uch8/s=";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    cp -r . $out

    rm -rf $out/.git $out/.github $out/.cursor $out/.agents $out/.codex-plugin \
           $out/.opencode $out/evals $out/tests $out/scripts $out/extensions \
           $out/skills/i-have-adhd/agents \
           $out/GEMINI.md $out/gemini-extension.json $out/kimi.plugin.json \
           $out/qwen-extension.json $out/opencode.json $out/package.json \
           $out/plugin.json

    cat > $out/hooks/hooks.json <<EOF
    {
      "hooks": {
        "SessionStart": [
          {
            "matcher": "startup|resume|clear|compact",
            "hooks": [
              {
                "type": "command",
                "command": "$out/hooks/always-on.sh",
                "timeout": 30,
                "statusMessage": "Loading i-have-adhd ruleset..."
              }
            ]
          }
        ]
      }
    }
    EOF

    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/ayghri/i-have-adhd";
    description = "Claude Code skill that shapes output for a reader with ADHD";
    platforms = lib.platforms.all;
    license = lib.licenses.mit;
  };
}
