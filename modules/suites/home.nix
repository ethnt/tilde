{ profiles }:

with profiles;

{
  base = [
    attic
    atuin
    autojump
    bat
    direnv
    emacs
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
    zellij
  ];

  development = [ git.common gh gh-dash vscode ];

  identity = [ gnupg.default ];

  work = [ git.large-repos mise ];

  minimal = [ autojump bat fish fzf git.common gh navi starship tools.common ];
}
