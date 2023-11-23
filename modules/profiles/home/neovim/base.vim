" Start NERDTree on start
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Show hidden files in NERDTree by default
let NERDTreeShowHidden=1

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
