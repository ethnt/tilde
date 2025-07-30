{ config, pkgs, ... }: {
  xdg.configFile."git/personal.gitconfig".text = ''
    [user]
      email = ethan@turkeltaub.dev
  '';

  programs.git.extraConfig = {
    includeIf."gitdir:~/Workspace/tilde" = {
      path = "${config.tilde.home.homeDirectory}/${
          config.xdg.configFile."git/personal.gitconfig".target
        }";
    };
  };
}
