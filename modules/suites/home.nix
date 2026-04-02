{ profiles }:

with profiles;

{
  base = [
    attic
    atuin
    autojump
    bat
    certs
    direnv
    fish
    fzf
    ghostty
    helix
    lazygit
    jujutsu
    navi
    paths
    rippkgs
    starship
    tmux.default
    tools.common
    tools.darwin
    xdg
    zed-editor
  ];

  development = [
    git.common
    git.difftastic
    git.mergiraf
    git.worktrunk
    gh
    gh-dash
    mise
    vscode
  ];

  identity = [ gnupg.default ];

  work = [ git.large-repos ];

  minimal = [ autojump bat fish fzf git.common gh navi starship tools.common ];
}
