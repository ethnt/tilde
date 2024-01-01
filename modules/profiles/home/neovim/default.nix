{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;

    vimAlias = true;

    extraConfig = ''
      ${builtins.readFile ./base.vim}
    '';

    plugins = with pkgs.vimPlugins; [
      ale
      deoplete-nvim
      fzf-vim
      lightline-vim
      nerdtree
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

  home.sessionVariables.EDITOR = pkgs.lib.getExe config.programs.neovim.package;
}
