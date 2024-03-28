{ profiles }:

with profiles;

{
  base = [
    autojump.default
    broot.default
    bat.default
    direnv.default
    fish.default
    fzf.default
    paths.default
    navi.default
    starship.default
    tmux.default
    tools.common
    tools.darwin
    tools.extra
  ];

  development = [ git.common gh.default vscode.default neovim.default ];

  programming = [ elixir.default ruby.default nodejs.default mise.default ];

  identity = [ gnupg.default ];

  work = [ git.large-repos ];

  minimal = [
    autojump.default
    bat.default
    fish.default
    fzf.default
    git.common
    gh.default
    neovim.default
    starship.default
    tools.common
  ];
}
