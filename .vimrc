:runtime! archlinux.vim

:set shiftwidth=4
:set autoindent
:set smartindent
:set tabstop=4
:set clipboard=unnamedplus
:set number
:set mouse=a
:set omnifunc=javascriptcomplete#CompleteJS
:set hlsearch

" File find 
:set path+=**
:set wildmenu
:set wildignore+=**/node_modules/**
:set hidden

call plug#begin()

Plug 'tpope/vim-commentary' " For Commenting gcc & gc
Plug 'vim-airline/vim-airline' " Status bar
Plug 'rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'jiangmiao/auto-pairs' "this will auto close ( [ {

" these two plugins will add highlighting and indenting to JSX and TSX files.
set encoding=UTF-8
call plug#end()
:colorscheme jellybeans
