{ pkgs, ... }: {
  programs.navi = {
    enable = true;
    enableFishIntegration = true;
    cheats = {
      main = ''
        % text

        # remove first line
        tail -n +2
      '';
    };
  };
}
