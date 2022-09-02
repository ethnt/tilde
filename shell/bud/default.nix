{ pkgs, lib, budUtils, ... }: {
  bud.cmds = let corePkgs = with pkgs; [ coreutils git git-crypt nixUnstable ];
  in {
    format = {
      synopsis = "format";
      script = ./cmd/format.bash;
      writer =
        budUtils.writeBashWithPaths (corePkgs ++ (with pkgs; [ nixfmt ]));
      help = "Check the formatting of the project";
    };

    lint = {
      synopsis = "lint";
      script = ./cmd/lint.bash;
      writer =
        budUtils.writeBashWithPaths (corePkgs ++ (with pkgs; [ dhall statix ]));
      help = "Lint the project";
    };

    build = {
      synopsis = "build [host]";
      script = ./cmd/build.bash;
      writer = budUtils.writeBashWithPaths corePkgs;
      help = "Build the defined Tilde configuration";
    };

    update-input = {
      synopsis = "update-input [input]";
      script = ./cmd/update-input.bash;
      writer = budUtils.writeBashWithPaths corePkgs;
      help = "Update a specific flake input";
    };

    repl = {
      synopsis = "repl [flake]";
      script = (import ./cmd/repl pkgs).outPath;
      writer = budUtils.writeBashWithPaths
        (corePkgs ++ (with pkgs; [ gnused mercurial ]));
      help = "Enter a REPL with the flake's outputs";
    };

    generate-ci = {
      synopsis = "generate-ci";
      script = ./cmd/generate-ci.bash;
      writer = budUtils.writeBashWithPaths (with pkgs; [ dhall-json ]);
      help = "Convert the CI configuration written in Dhall to Yaml";
    };
  };
}
