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

  development = [ asdf git.common gh vscode neovim ];

  programming = [ elixir ruby ];

  identity = [ gnupg ];

  work = [ git.large-repos ];

  minimal =
    [ autojump bat fish fzf git.common gh neovim starship tools.common ];
}
