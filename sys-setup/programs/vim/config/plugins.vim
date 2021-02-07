set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')
  Plug 'sheerun/vim-polyglot'
  Plug 'mhinz/vim-startify'
  Plug 'airblade/vim-gitgutter'
  Plug 'wakatime/vim-wakatime'
  Plug 'dense-analysis/ale'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  " Plug 'junegunn/fzf.vim'
  " Plug 'ap/vim-css-color'

  " Plug 'haya14busa/incsearch.vim'
  " Plug 'tpope/vim-fugitive'
call plug#end()
