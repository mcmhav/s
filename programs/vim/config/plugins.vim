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
  " - gitgutter ~620 - slow to add gutterinfo in unchanged->changed
  "   suggest not not use this on r-pi
  " - incsearch ~525 - might be redundant
  " - waka ~540
  " - polyglot ~820
  " - fugutive ~560
  "
  " - startify+fzf+css+waka+fugitive ~640, wut?

  " Low impact on startup time
  " Plug 'mhinz/vim-startify'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'ap/vim-css-color'
  " Plug 'wakatime/vim-wakatime'
  Plug 'tpope/vim-fugitive'
  " Test for now, remove if no large benefit is seen as default seach works pretty well
  Plug 'haya14busa/incsearch.vim'

  " Low impact, might be causing the lags?
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Do not use on pi
  if $CSYS_OS != "pi"
    Plug 'airblade/vim-gitgutter'
  " impact, config-issues?
    Plug 'sheerun/vim-polyglot' " high startup-inpact, claims to be low
    Plug 'github/copilot.vim', {'branch': 'release'}
  endif

  " Untested - check if we can remove this, in favour of doing all with coc
  " Plug 'dense-analysis/ale'

  " New untested
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  " something like
  " :vert lefta 50sp term:////git --no-pager blame --date relative -- % | awk -F'ago ' '{print $1}'
  " could perhaps do the
  " trick, but this is more convenient
  " mostly used for blame
  Plug 'tpope/vim-fugitive'

  " Coc extensions:
  " Plug 'iamcco/coc-diagnostic', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'yaegassy/coc-ruff', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'fannheyward/coc-markdownlint', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'fannheyward/coc-pyright', {'do': 'yarn install --frozen-lockfile'}
call plug#end()
