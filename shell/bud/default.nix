{ pkgs, lib, budUtils, ... }: {
  bud.cmds = {
    "ci.format" = {
      synopsis = "ci.format";
      script = ./cmd/ci-format.bash;
      writer = budUtils.writeBashWithPaths
        (with pkgs; [ coreutils git nixUnstable nixfmt ]);
      help = "Check the formatting of the project";
    };

    "ci.lint" = {
      synopsis = "ci.lint";
      script = ./cmd/ci-lint.bash;
      writer = budUtils.writeBashWithPaths
        (with pkgs; [ coreutils git nixUnstable statix ]);
      help = "Lint the project with Statix";
    };

    "ci.shellcheck" = {
      synopsis = "ci.shellcheck";
      script = ./cmd/ci-shellcheck.bash;
      writer = budUtils.writeBashWithPaths
        (with pkgs; [ coreutils git nixUnstable fd shellcheck ]);
      help = "Check bash files with Shellcheck";
    };

    "ci.dhall" = {
      synopsis = "ci.dhall";
      script = ./cmd/ci-dhall.bash;
      writer = budUtils.writeBashWithPaths
        (with pkgs; [ coreutils git nixUnstable dhall ]);
      help = "Check Dhall file formatting";
    };

    build = {
      synopsis = "build [host]";
      script = ./cmd/build.bash;
      writer =
        budUtils.writeBashWithPaths (with pkgs; [ coreutils git nixUnstable ]);
      help = "Build the defined Tilde configuration";
    };

    update-input = {
      synopsis = "update-input [input]";
      script = ./cmd/update-input.bash;
      writer =
        budUtils.writeBashWithPaths (with pkgs; [ coreutils git nixUnstable ]);
      help = "Update a specific flake input";
    };

    repl = {
      synopsis = "repl [flake]";
      script = (import ./cmd/repl pkgs).outPath;
      writer = budUtils.writeBashWithPaths
        (with pkgs; [ nixUnstable gnused git mercurial coreutils ]);
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
