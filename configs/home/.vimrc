set number
set mouse=a
syntax on
filetype indent plugin on
set wildmenu
set showcmd
set tabstop=4
set autoindent
set expandtab
set softtabstop=4
autocmd Filetype gitcommit setlocal spell
set backspace=indent,eol,start 
set hidden
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif