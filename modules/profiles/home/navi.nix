{
  programs.navi = {
    enable = true;
    enableFishIntegration = true;
    cheats = {
      files = ''
        % files

        # search for string in files
        grep -rnw '<path>' -e '<string>'
      '';

      git = ''
        % git

        # Checkout a remote branch
        git fetch origin <branch-name>:<branch-name>; git checkout <branch-name>
      '';
    };
  };
}
