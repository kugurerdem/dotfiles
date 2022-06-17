set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set hlsearch                " highlight search 
set nohlsearch
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set relativenumber
syntax on                   " syntax highlighting
set clipboard=unnamedplus   " using system clipboard

call plug#begin()

"Theme and view
Plug 'rafi/awesome-vim-colorschemes' " Retro Scheme

" Plugins
Plug 'tpope/vim-commentary' " For Commenting gcc & gc
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'vimwiki/vimwiki'

" These are for fuzzy finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

set encoding=UTF-8
call plug#end()

" awesome-vim-colorschemes config
colorscheme jellybeans

" MarkdownPreview Config
function OpenMarkdownPreview (url)
execute "silent ! brave --new-window " . a:url
endfunction

let g:mkdp_browser = 'brave'
let g:mkdp_browserfunc = 'OpenMarkdownPreview'
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

" VimWiki Config
" Vim Wiki
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext':'.md'}]


" HOTKEYS
map <C-p> :Files<CR>
