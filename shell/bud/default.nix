{ pkgs, lib, budUtils, ... }: {
  bud.cmds = {
    build = {
      synopsis = "build [host]";
      script = ./cmd/build.bash;
      writer =
        budUtils.writeBashWithPaths (with pkgs; [ coreutils git nixUnstable ]);
      help = "Switch to the defined Tilde configuration";
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
      writer = budUtils.writeBashWithPaths
        (with pkgs; [ nixUnstable gnused git mercurial coreutils ]);
      help = "Enter a REPL with the flake's outputs";
      script = (import ./cmd/repl pkgs).outPath;
    };
  };
}
