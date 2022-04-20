{ pkgs, ... }: {
  # BUG: This doesn't set $SSH_AUTH_SOCK correctly -- we set it in the gnupg home program instead
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
