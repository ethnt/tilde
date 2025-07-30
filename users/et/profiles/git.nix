{ config, pkgs, lib, ... }: {
  xdg.configFile."git/personal.gitconfig.txt".text = ''
    [user]
      email = ethan@turkeltaub.dev
  '';

  programs.git = {
    # userEmail = "et@mercury.com";
    # userName = "Ethan Turkeltaub";

    extraConfig = {
      user = {
        # email = "et@mercury.com";
        name = "Ethan Turkeltaub";
      };

      includeIf."gitdir/i:~/Workspace/personal/".path =
        "${config.xdg.configHome}/git/personal.gitconfig.txt";
    };
  };
}
