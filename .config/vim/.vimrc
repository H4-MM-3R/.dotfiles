"----- SETTINGS ----
set guicursor=
set number
set relativenumber
set scrolloff=8
set tabstop=4 softtabstop=4
set expandtab
set smartindent
set termguicolors
syntax enable
set background=dark

"---- PLUGINS ----
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ericbn/vim-solarized'
call plug#end()

" ---- COLORSCHEME ----

colorscheme solarized

" ---- KEYMAPS ----
let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader><CR> :so ~/.vimrc<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>
inoremap jj <Esc>
vnoremap <leader>p "_dP
vnoremap <leader>y "+y
nnoremap <leader>d diwb
nnoremap <leader>c ciw



