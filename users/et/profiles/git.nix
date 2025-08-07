{ config, ... }: {
  xdg.configFile."git/mercury.gitconfig".text = ''
    [user]
      email = et@mercury.com
  '';

  xdg.configFile."git/personal.gitconfig".text = ''
    [user]
      email = ethan@turkeltaub.dev
  '';

  programs.git.extraConfig = {
    includeIf."gitdir/i:~/Workspace/mercury/".path =
      "${config.home.homeDirectory}/${
        config.xdg.configFile."git/mercury.gitconfig".target
      }";

    includeIf."gitdir/i:~/Workspace/personal/".path =
      "${config.home.homeDirectory}/${
        config.xdg.configFile."git/personal.gitconfig".target
      }";
  };
}
