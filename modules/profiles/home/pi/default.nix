{
  programs.pi-coding-agent = {
    enable = true;
  };

  home.file = {
    ".pi/agent/extensions/confirm-writes.ts" = {
      source = ./extensions/confirm-writes.ts;
    };
  };
}
