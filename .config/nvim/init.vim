if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/local/share/nvim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-sleuth'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdTree'
Plug 'ap/vim-css-color'
Plug 'dense-analysis/ale'
Plug 'terryma/vim-multiple-cursors'

Plug 'HerringtonDarkholme/yats.vim'
Plug 'MaxMEllon/vim-jsx-pretty'

Plug 'vimwiki/vimwiki'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'

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
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set hlsearch                " highlight search results
set tabstop=2               " number of columns occupied by a tab character
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
" set number                  " add line numbers
set number relativenumber
" set cursorline
" hi clear CursorLine
" hi CursorLine gui=underline cterm=underline
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting
" let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
colorscheme seoul256 
let g:material_theme_style = 'ocean'
set background=dark
let g:airline_powerline_fonts = 1
let g:airline_theme='term'
let g:cssColorVimDoNotMessMyUpdatetime = 1

" Plugin configuration

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let b:ale_linters = ['pyflakes', 'flake8', 'pylint']
let g:ale_completion_enabled = 1


"set filetypes
au BufRead,BufNewFile *.txt setfiletype text

"show all diagnostics.
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
"manage extensions.
nnoremap <silent> <space>e :<C-u>CocList extensions<cr>

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

" auto-pairs

nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>


" nerdTree keybind
nmap <C-n> :NERDTreeToggle<CR>

" autocmds

set nohlsearch
