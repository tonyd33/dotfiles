" vim-plug automatic installation {{{
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}


" plugins {{{
call plug#begin()
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'machakann/vim-sandwich'
Plug 'jiangmiao/auto-pairs'
Plug 'ap/vim-css-color'
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'adelarsq/vim-matchit'
Plug 'preservim/nerdcommenter'
Plug 'vimwiki/vimwiki'

" themes
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
" }}}


" misc {{{
let mapleader = " "
filetype plugin indent on           " allows auto-indenting depending on file type
syntax on                           " syntax highlighting
set number relativenumber           " show absolute line as well as relative line numbers
set showmatch                       " show matching brackets
set cc=80                           " column count
set tabstop=2
set shiftwidth=4
set expandtab
set hlsearch                        " highlight search results
set listchars=tab:>~,nbsp:_,trail:. " detect whitespace characters
set list
setlocal foldmethod=syntax          " folding via syntax for this filetype
set foldlevel=99                    " start with folds open
set autoindent                      " indent a new line the same amount as the line just typed
set cursorline
set t_Co=256                        " set 256 terminal colors
set nocompatible                    " used for vimwiki
" }}}

" plugin configuration {{{1

" nerdcommenter {{{
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" }}}

" vim-easy-align {{{
" start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" airline {{{
let g:airline_powerline_fonts = 1
let g:airline_theme='onehalfdark'
" }}}

" vim-sandwich {{{
" set vim-surround keymap for vim-sandwich
runtime macros/sandwich/keymap/surround.vim
" }}}

" vim-easymotion {{{
map <leader> <Plug>(easymotion-prefix)
map s <Plug>(easymotion-prefix)s
" }}}

" vim-css-colors {{{
function s:CssColorInit(typ, keywords, groups)
  try
    call css_color#init(a:typ, a:keywords, a:groups)
  catch /^Vim\%((\a\+)\)\=:E117/
    echom 'ap/vim-css-color not yet installed.'
  endtry 
endfunction

augroup CssColorCustomFiletypes
  autocmd!
  autocmd Filetype conf call s:CssColorInit('hex', 'none', 'confComment')
  autocmd Filetype haskell call s:CssColorInit('hex', 'none', 'haskellLineComment,haskellString,haskellBlockComment')
augroup END
" }}}

" 1}}}

" maps {{{
" normal mode on escape
tnoremap <Esc> <C-\><C-n>
" clear search on enter
nnoremap <silent> <CR> :noh<CR><Esc>
" center on search
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz
" change working directory for current window
nnoremap <leader><leader>cwd :lcd %:p:h<CR>
" }}}

" theming {{{
colorscheme onehalfdark
set background=dark
" }}}


" treat .dot files without the prefix {{{
function s:ChangeDotFileType()
  let ext = expand('%:e')
  let filename_orig = @%
  if ext != "dot"
    return
  endif
  let file_dot_stripped = substitute(filename_orig, '.dot', '', '')
  execute "file " file_dot_stripped
  filetype detect
  execute "file " filename_orig
endfunction
autocmd BufWinEnter *.dot :call s:ChangeDotFileType()
" }}}

" numbered tab lines {{{
" credit: https://vim.fandom.com/wiki/Show_tab_number_in_your_tab_line
if exists("+showtabline")
     function NumberedTabs()
         let s = ''
         let t = tabpagenr()
         let i = 1
         while i <= tabpagenr('$')
             let buflist = tabpagebuflist(i)
             let winnr = tabpagewinnr(i)
             let s .= '%' . i . 'T'
             let s .= (i == t ? '%1*' : '%2*')
             let s .= ' '
             let s .= i . ')'
             let s .= ' %*'
             let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
             let file = bufname(buflist[winnr - 1])
             let file = fnamemodify(file, ':p:t')
             if file == ''
                 let file = '[No Name]'
             endif
             let s .= file
             let i = i + 1
         endwhile
         let s .= '%T%#TabLineFill#%='
         let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
         return s
     endfunction
     set stal=2
     set tabline=%!NumberedTabs()
endif
" }}}

" auto save folds
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview

" vim:foldmethod=marker
