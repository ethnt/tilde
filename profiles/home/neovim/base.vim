set number
set sts=2
set ts=2
set sw=2
set expandtab
set mouse=nv

" Ctrl + p to open file picker
map <C-p> :GFiles<CR>

" `:Ag` to find in files
map <Leader>f :Ag <CR>

" Ctrl + l to clear highlighting from search
map <C-l> :nohl <CR>

" `:g` to open git status
map <Leader>g :Gstatus <CR>

" Yank to system clipboard
vnoremap  <leader>y  "+y
set ignorecase
set smartcase
set incsearch

" Set ALE colors
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight ALEWarning ctermbg=DarkMagenta
