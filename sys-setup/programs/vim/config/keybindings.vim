"inoremap qq <Esc>
"inoremap QQ <Esc>
"nnoremap qq :noh<return><Esc>

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

" Coc
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Search
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
