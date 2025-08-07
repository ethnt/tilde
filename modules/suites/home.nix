{ profiles }:

with profiles;

{
  base = [
    autojump.default
    attic.default
    broot.default
    bat.default
    direnv.default
    emacs.default
    fish.default
    fzf.default
    ghostty.default
    helix.default
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

  work = [
    amazon-ecr-credential-helper.default
    awscli.default
    git.large-repos
    mise.default
    rider.default
  ];

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
