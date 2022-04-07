" Plugged
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/local/share/nvim/plugged')
Plug 'lervag/vimtex'
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-sleuth'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdTree'
Plug 'ap/vim-css-color'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/taglist.vim'
Plug 'ggandor/lightspeed.nvim'
Plug 'ivyl/vim-bling'
Plug 'tpope/vim-repeat'

Plug 'HerringtonDarkholme/yats.vim'
Plug 'MaxMEllon/vim-jsx-pretty'

Plug 'vimwiki/vimwiki'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'

" Themes
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'rakr/vim-one'
Plug 'jdkanani/vim-material-theme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/seoul256.vim'
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
call plug#end()


set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc

let mapleader = " "
set nocompatible            " disable compatibility to old-time vi
filetype plugin on
syntax on
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set hlsearch                " highlight search results
set tabstop=2               " number of columns occupied by a tab character
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number relativenumber
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

colorscheme onehalfdark
set background=dark
let g:airline_powerline_fonts = 1
let g:airline_theme='onehalfdark'
let g:cssColorVimDoNotMessMyUpdatetime = 1

nnoremap <leader>t gt
nnoremap <leader>T gT

nnoremap <leader>ll :Tlist<CR>

" Clear search on enter
nnoremap <silent> <CR> :noh<CR><Esc>

" Window splitting
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

" Plugin configuration
let b:ale_linters = ['pyflakes', 'flake8', 'pylint']
let g:ale_completion_enabled = 1

let g:Tlist_Inc_Winwidth = 0

" set vim-surround keymap for vim-sandwich
runtime macros/sandwich/keymap/surround.vim

" auto-pairs
nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>


" nerdTree keybind
nmap <C-n> :NERDTreeToggle<CR>

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" autocmds
" Open NERDTree on launch
" autocmd VimEnter * NERDTree | wincmd p

" register to clipboard
:vmap <leader>cp ;w !xclip -i -sel c<CR><CR>

" Vimtex
filetype plugin indent on
syntax enable

let g:vimtex_view_method = 'zathura'

" Swap : and ;
noremap ; :
" Don't do : and let lightspeed take it over
noremap : <Plug>Lightspeed_;_ft

