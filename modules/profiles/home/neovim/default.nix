{ config, pkgs, ... }: {
  programs.nixvim = {
    enable = true;

    extraConfigVim = ''
      set number
      set sts=2
      set ts=2
      set sw=2
      set expandtab
      set mouse=nv

      " Ctrl + p to open file picker
      map <C-p> :GFiles<CR>

      " Yank to system clipboard
      vnoremap <leader>y "+y

      set ignorecase
      set smartcase
      set incsearch
    '';

    plugins = {
      commentary.enable = true;
      fugitive.enable = true;
      lightline.enable = true;
      nix.enable = true;
      which-key.enable = true;
      surround.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [ fzf-vim ];
  };

  home.sessionVariables.EDITOR = pkgs.lib.getExe config.programs.neovim.package;
}
