{
  programs.navi = {
    enable = true;
    enableFishIntegration = true;

    cheatfiles.git = {
      tags = [ "git" ];
      cheats = [{
        description = "checkout a remote branch";
        command = ''
          git fetch origin <branch-name>:<branch-name>
          git checkout <branch-name>
        '';
      }];
    };
  };
}
