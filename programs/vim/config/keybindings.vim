inoremap jj <Esc>
inoremap JJ <Esc>
"nnoremap qq :noh<return><Esc>
"inoremap QQ <Esc>

" Move line
nnoremap ª :m .-2 <CR>
nnoremap √ :m .+1 <CR>
inoremap ª <Esc> :m .-2 <CR>==gi
inoremap √ <Esc> :m .+1 <CR>==gi
vnoremap ª :m '<-2' <CR> gv=gv
vnoremap √ :m '>+1' <CR> gv=gv

" Reload vims configuration file
nnoremap confr :source $MYVIMRC<CR>

" Make session
exec 'nnoremap ,ss :mksession ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'

" Fuzzy find file
nnoremap <silent> ,f :FZF<cr>
nnoremap <silent> ,F :FZF ~<cr>
inoremap <C-p>,F :FZF ~<cr>

" Search all
nnoremap <silent> ,s :Ag<cr>

" Coc
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

" Search
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" Clipboard
set clipboard=unnamed

" Quoting
" Matching brackets
inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha
" :s/\%V\(.*\)\%V/"\1"/
"vnoremap i :s/\%V\(.*\)\%V/"\1"/ <ESC>
