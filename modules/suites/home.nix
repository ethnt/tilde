{ profiles }:

with profiles;

{
  base = [
    autojump.default
    attic.default
    broot.default
    bat.default
    direnv.default
    fish.default
    fzf.default
    ghostty.default
    paths.default
    navi.default
    rippkgs.default
    starship.default
    tmux.default
    tools.common
    tools.darwin
    tools.extra
  ];

  development = [ git.common gh.default vscode.default neovim.default ];

  identity = [ gnupg.default ];

  work = [ git.large-repos ];

  minimal = [
    autojump.default
    bat.default
    fish.default
    fzf.default
    git.common
    gh.default
    navi.default
    neovim.default
    starship.default
    tools.common
  ];
}
