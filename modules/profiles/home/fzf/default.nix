{ pkgs, ... }: {
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultCommand = "${pkgs.fd}/bin/fd --exclude /.git -H";
  };
}
