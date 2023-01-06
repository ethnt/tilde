{ pkgs, ... }: {
  programs.neovim = {
    enable = true;

    vimAlias = true;

    extraConfig = ''
      ${builtins.readFile ./base.vim}
    '';

    extraPackages = with pkgs; [ ranger ];

    plugins = with pkgs.vimPlugins; [
      ale
      deoplete-nvim
      fzf-vim
      lightline-vim
      ranger-vim
      solarized
      tabular
      vim-autoformat
      vim-commentary
      vim-elixir
      vim-fugitive
      vim-markdown
      vim-nix
    ];
  };
}
