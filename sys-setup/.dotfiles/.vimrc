set nocompatible              " be iMproved, required
filetype off                  " required

" Plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
call vundle#end()
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'wakatime/vim-wakatime'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ap/vim-css-color'
Plug 'haya14busa/incsearch.vim'
call plug#end()

" Syntax
let g:vim_jsx_pretty_colorful_config = 1
syntax on
set t_Co=256
set background=dark
set termguicolors
colorscheme cake

set number
autocmd BufWritePre * :%s/\s\+$//e
let g:netrw_banner = 0
set autoread

" Indenting
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab
set smarttab
set autoindent
set cindent
filetype indent off
"filetype plugin indent on

" Autoformat
autocmd InsertLeave * w
autocmd InsertLeave *.yaml,*.html,*.js,*.css ALEFix
"autocmd BufLeave,InsertLeave * wall
"autocmd BufLeave * wall
"autocmd WinLeave * :ALEFix | :write
let g:ale_fixers = {
\  'javascript': ['prettier'],
\  'json': ['prettier'],
\  'css': ['prettier'],
\  'scss': ['prettier'],
\  'html': ['prettier'],
\  'xml': ['prettier'],
\}
let g:ale_fix_on_save = 1


" Sessions
let g:sessions_dir = '~/.vim/sessions'
let g:startify_session_persistence = 1
let g:startify_session_dir = g:sessions_dir
let g:startify_custom_header_quotes = [
  \ [
    \ '    ___       ___       ___       ___',
    \ '   /\  \     /\  \     /\__\     /\  \',
    \ '  /::\  \   /::\  \   /:/ _/_   /::\  \',
    \ ' /:/\:\__\ /::\:\__\ /::-"\__\ /::\:\__\',
    \ ' \:\ \/__/ \/\::/  / \;:;-",-" \:\:\/  /',
    \ '  \:\__\     /:/  /   |:|  |    \:\/  /',
    \ '   \/__/     \/__/     \|__|     \/__/',
    \ '',
  \ ]
\ ]

" Splits
set splitbelow
set splitright

" Statusbar
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#format = 2
"let g:airline#extensions#tabline#show_splits = 1
"let g:airline#extensions#tabline#show_buffers = 0
"let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'bubblegum'
let g:airline_mode_map = {
  \ '__'     : '-',
  \ 'c'      : 'C',
  \ 'i'      : 'I',
  \ 'ic'     : 'I',
  \ 'ix'     : 'I',
  \ 'n'      : 'N',
  \ 'multi'  : 'M',
  \ 'ni'     : 'N',
  \ 'no'     : 'N',
  \ 'R'      : 'R',
  \ 'Rv'     : 'R',
  \ 's'      : 'S',
  \ 'S'      : 'S',
  \ ''     : 'S',
  \ 't'      : 'T',
  \ 'v'      : 'V',
  \ 'V'      : 'V',
  \ ''     : 'V',
\ }
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.dirty='*'
function! AirlineInit()
  " let g:airline_section_b = '%{FugitiveStatusline()}'
  let g:airline_section_c = airline#section#create(['%t', 'readonly', ' ', 'coc_status'])
  let g:airline_section_y = ''
  let g:airline_section_z = airline#section#create(['%4l', '%3v'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch
autocmd InsertEnter * :set nohlsearch
autocmd InsertLeave * :set hlsearch
let g:incsearch#auto_nohlsearch = 0
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" Keybindings
inoremap qq <Esc>
inoremap QQ <Esc>
nnoremap qq :noh<return><Esc>
" Move line
nnoremap <A-Up> :m .-2 <CR>
nnoremap <A-Down> :m .+1 <CR>
inoremap <A-Up> <Esc> :m .-2 <CR>
inoremap <A-Down> <Esc> :m .+1 <CR>
vnoremap <A-Up> :m '<-2' <CR> gv=gv
vnoremap <A-Down> :m '>+1' <CR> gv=gv
" Reload vims configuration file
nnoremap confr :source $MYVIMRC<CR>
" Make session
exec 'nnoremap ,ss :mksession ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
" Fuzzy find file
nnoremap <silent> ,f :FZF<cr>
nnoremap <silent> ,F :FZF ~<cr>
" Search all
nnoremap <silent> ,s :Ag<cr>
