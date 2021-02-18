set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'mhinz/vim-startify'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " Plug 'airblade/vim-gitgutter'
  " Plug 'wakatime/vim-wakatime'
  " Plug 'dense-analysis/ale'

  " Plug 'ap/vim-css-color'

  " Plug 'haya14busa/incsearch.vim'
  " Plug 'sheerun/vim-polyglot'
  " Plug 'tpope/vim-fugitive'
call plug#end()
