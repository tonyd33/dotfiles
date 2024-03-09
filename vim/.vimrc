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
Plug 'vim-airline/vim-airline-themes'
Plug 'machakann/vim-sandwich'
Plug 'jiangmiao/auto-pairs'
Plug 'ap/vim-css-color'
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
" +/- on gutter lines
Plug 'airblade/vim-gitgutter'
" :Git commands
Plug 'tpope/vim-fugitive'
" Extended matching for %
Plug 'adelarsq/vim-matchit'
Plug 'preservim/nerdcommenter'
Plug 'vimwiki/vimwiki'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }

Plug 'preservim/nerdtree'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

" ⚠ bloat ⚠
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" themes
" Plug '~/git/dotfiles/onehalf', { 'rtp': 'vim' }
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
call plug#end()
" }}}

let g:catppuccin_flavour="frappe"
colorscheme catppuccin

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
set ignorecase
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
" let g:airline_powerline_fonts = 1
let g:airline_theme='catppuccin'
" }}}

" vim-sandwich {{{
" set vim-surround keymap for vim-sandwich
runtime macros/sandwich/keymap/surround.vim
" }}}

" vim-easymotion {{{
map <leader> <Plug>(easymotion-prefix)
map s <Plug>(easymotion-prefix)s
" }}}

" coc {{{
if !exists("*CocEableAndStart")
    function CocEnableAndStart()
        :CocEnable
        :CocRestart
    endfunction
endif
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

nnoremap <leader>sn :CocAction("showSignatureHelp")<CR>

nnoremap <leader>rn <Plug>(coc-rename)
nmap <leader>qf  <Plug>(coc-fix-current)
" don't waste resources
let g:coc_start_at_startup = v:false
" unless necessary
nnoremap <silent> <leader>bs :call CocEnableAndStart()<CR>
" or not
nnoremap <leader>bd :CocDisable<CR>
" }}}

" {{{ Telescope
nnoremap <leader>gf <cmd>Telescope find_files<CR>
nnoremap <leader>gF <cmd>Telescope live_grep<cr>
" }}}

" {{{ NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" }}}

" 1}}}

" maps {{{
" normal mode on escape in term mode
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
" copy path from working directory
nnoremap <leader>cp :let @+=@%<CR>
" }}}

" theming {{{
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
" }}}

" auto save folds
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview

" vim:foldmethod=marker
