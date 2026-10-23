{ pkgs, ... }: {
  programs.pi-coding-agent = {
    enable = true;
    package = pkgs.llm-agents.pi;
    settings = {
      packages = [
        "npm:pi-zentui"
        "npm:pi-lens"
        "git:github.com/ayghri/i-have-adhd"
      ];
    };
  };

  home.file = {
    ".pi/agent/extensions/confirm-writes.ts" = {
      source = ./extensions/confirm-writes.ts;
    };
  };
}
