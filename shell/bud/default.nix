{ pkgs, lib, budUtils, ... }: {
  bud.cmds = {
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

    update-sources = {
      synopsis = "update-sources";
      script = ./cmd/update-sources.bash;
      writer = budUtils.writeBashWithPaths
        (with pkgs; [ coreutils git nixUnstable nvfetcher-bin ]);
      help = "Update other sources";
    };
  };
}
