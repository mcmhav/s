let g:airline_extensions = []
" let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#format = 2
"let g:airline#extensions#tabline#show_splits = 1
"let g:airline#extensions#tabline#show_buffers = 0
"let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'angr'
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

