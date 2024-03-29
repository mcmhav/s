let s:gui_dark_gray = '#303030'
let s:cterm_dark_gray = 236
let s:gui_med_gray_hi = '#444444'
let s:cterm_med_gray_hi = 238
let s:gui_med_gray_lo = '#3a3a3a'
let s:cterm_med_gray_lo = 237
let s:gui_light_gray = '#b2b2b2'
let s:cterm_light_gray = 249
let s:gui_green = '#005f87'
let s:cterm_green = 150
let s:gui_blue = '#87afd7'
let s:cterm_blue = 110
let s:gui_purple = '#afafd7'
let s:cterm_purple = 146
let s:gui_orange = '#ffaf87'
let s:cterm_orange = 216
let s:gui_red = '#d78787'
let s:cterm_red = 174
let s:gui_pink = '#d7afd7'
let s:cterm_pink = 182

let g:currentmode = {
\ 'n'  : 'n',
\ 'v'  : 'v',
\ 'V'  : 'v',
\ '' : 'v',
\ 'i'  : 'i',
\ 'R'  : 'r',
\ 'Rv' : 'rv',
\ 'c'  : 'c',
\ 't'  : 'f',
\}

function! RaiRai()
  let m = mode(1)
  if m[0] ==# "i"
    return printf('%%(%%#%s#%s%%)','InsertMode', " I ")
  endif

  return 'nothing'
endfunction

" Left
set statusline=
"set statusline+=%{(RaiRai())}
set statusline+=%#NormalMode#%{(mode()=='n')?'\ \ N\ ':''}
set statusline+=%#InsertMode#%{(mode()=='i')?'\ \ I\ ':''}
set statusline+=%#ReplaceMode#%{(mode()=='r')?'\ \ R\ ':''}
" Visual
" set statusline+=%#VisualMode#%{(mode()=='v')?'\ \ V\ ':''}
set statusline+=%#VisualMode#%{(g:currentmode[mode()]=='v')?'\ \ V\ ':''}
" Command
set statusline+=%#CommandMode#%{(mode()=='c')?'\ \ C\ ':''}

set statusline+=%#Visual#
set statusline+=\ %t
set statusline+=%m

" Right
set statusline+=%=

set statusline+=%#CursorColumn#
set statusline+=\ %y

set statusline+=\ %#LinePosition#
set statusline+=\ %l:%c
set statusline+=%{'\ '}

set laststatus=2

