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
set noshowmode

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
  \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" netrw
" http://vimdoc.sourceforge.net/htmldoc/pi_netrw.html#netrw-P
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_preview = 1
let g:netrw_winsize = 25
let g:netrw_alto  = 'sb'
let g:netrw_altv = 'spr'

" let g:netrw_localrmdir='rm -r'
"let g:netrw_chgwin = 1

" Cursor
" https://stackoverflow.com/questions/6488683/how-to-change-the-cursor-between-normal-and-insert-modes-in-vim/42118416#42118416
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Folding
set foldmethod=indent
set foldlevelstart=99
