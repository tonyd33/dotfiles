" plugins {{{
call plug#begin()
" themes
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
call plug#end()
" }}}

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
