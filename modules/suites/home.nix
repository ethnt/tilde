{ profiles }:

with profiles;

{
  base = [
    attic
    autojump
    bat
    direnv
    fish
    fzf
    ghostty
    helix
    navi
    paths
    rippkgs
    starship
    tmux.default
    tools.common
    tools.darwin
    xdg
  ];

  development = [ git.common gh vscode neovim ];

  identity = [ gnupg.default ];

  work = [ git.large-repos mise ];

  minimal =
    [ autojump bat fish fzf git.common gh navi neovim starship tools.common ];
}
