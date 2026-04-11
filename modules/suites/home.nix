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
    sops
    starship
    tmux.default
    tools.common
    tools.darwin
    xdg
    zed-editor
  ];

  development = [
    claude-code
    git.common
    git.difftastic
    git.mergiraf
    git.worktrunk
    gh
    gh-dash
    mcp.default
    mcp.github.default
    mcp.nixos
    mise
    vscode
  ];

  identity = [ gnupg.default ];

  work = [ git.large-repos ];

  minimal = [ autojump bat fish fzf git.common gh navi starship tools.common ];
}
