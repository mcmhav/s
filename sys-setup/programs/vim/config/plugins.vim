set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')
  " pi3 timings:
  " - no enabled - empty ~420
  " - no enabled - bash ~600
  " - vim-startify - bash ~600
  " - vim-startify - empty ~555
  " - coc ~710
  " - fzf ~620
  " - coc+fzf ~750
  " - coc+fzf+startify ~750
  " - fzf+startify ~620
  " - air'line ~1175
  " - css-color ~545
  " - startify+css ~555

  " Low impact on startup time
  "Plug 'mhinz/vim-startify'
  "Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  "Plug 'junegunn/fzf.vim'
  "Plug 'ap/vim-css-color'

  " Low impact, might be causing the lags?
  "Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Untested
  " Plug 'airblade/vim-gitgutter'
  " Plug 'wakatime/vim-wakatime'
  " Plug 'dense-analysis/ale'

  " Plug 'haya14busa/incsearch.vim'
  " Plug 'sheerun/vim-polyglot'
  " Plug 'tpope/vim-fugitive'
call plug#end()
