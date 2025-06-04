{ pkgs, ... }: {
  programs.git.includes = [{
    path = pkgs.writeText "fern.gitconfig" ''
      [user]
        email = ethan@buildwithfern.com
        signingKey = 0xA49E606DD0CE7B9C
    '';
    condition = "gitdir:$HOME/Workspace/fern/";
  }];
}
