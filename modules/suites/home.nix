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
    micro.default
    navi.default
    starship.default
    tmux.default
    tools.common
    tools.darwin
    tools.extra
  ];

  development =
    [ asdf.default git.common gh.default vscode.default neovim.default ];

  programming = [ elixir.default ruby.default ];

  identity = [ gnupg.default ];

  work = [ git.large-repos ];

  minimal =
    [ autojump bat fish fzf git.common gh neovim starship tools.common ];
}
