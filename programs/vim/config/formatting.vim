" Syntax
let g:vim_jsx_pretty_colorful_config = 1
syntax on
set t_Co=256
set background=dark
set termguicolors
colorscheme cake

set number
set relativenumber
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
set breakindent
"filetype plugin indent on

" Autoformat
" Slow for coc-python, add here instead of coc-settings.json
au BufWrite *.py call CocAction('format')
"autocmd InsertLeave * w
"autocmd InsertLeave *.yaml,*.html,*.js,*.css ALEFix
"autocmd BufLeave,InsertLeave * wall
"autocmd BufLeave * wall
"autocmd WinLeave * :ALEFix | :write

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch
autocmd InsertEnter * :set nohlsearch
autocmd InsertLeave * :set hlsearch
let g:incsearch#auto_nohlsearch = 0
