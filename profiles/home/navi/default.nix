{ pkgs, ... }: {
  programs.navi = {
    enable = true;
    enableFishIntegration = true;
    cheats = {
      main = ''
        % files

        # search for string in files
        grep -rnw '<path>' -e '<string>'
      '';
    };
  };
}
