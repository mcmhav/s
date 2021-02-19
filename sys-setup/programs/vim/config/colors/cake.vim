" Init
" ----
if !has("gui_running") && &t_Co < 256
  finish
endif

if ! exists("g:cake_gui_italic")
    let g:cake_gui_italic = 1
endif

if ! exists("g:cake_term_italic")
    let g:cake_term_italic = 0
endif

let g:cake_termcolors = 256 " does not support 16 color term right now.

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "cake"

function! CHG(group, style)
  let s:ctermformat = "NONE"
  let s:guiformat = "NONE"
  if has_key(a:style, "format")
    let s:ctermformat = a:style.format
    let s:guiformat = a:style.format
  endif
  if g:cake_term_italic == 0
    let s:ctermformat = substitute(s:ctermformat, ",italic", "", "")
    let s:ctermformat = substitute(s:ctermformat, "italic,", "", "")
    let s:ctermformat = substitute(s:ctermformat, "italic", "", "")
  endif
  if g:cake_gui_italic == 0
    let s:guiformat = substitute(s:guiformat, ",italic", "", "")
    let s:guiformat = substitute(s:guiformat, "italic,", "", "")
    let s:guiformat = substitute(s:guiformat, "italic", "", "")
  endif
  if g:cake_termcolors == 16
    let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm16 : "NONE")
    let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm16 : "NONE")
  else
    let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm : "NONE")
    let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm : "NONE")
  end
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")      ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")      ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")      ? a:style.sp.gui   : "NONE")
    \ "gui="     (!empty(s:guiformat) ? s:guiformat   : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (!empty(s:ctermformat) ? s:ctermformat   : "NONE")
endfunction

" Palettes
" --------

let s:white       = { "gui": "#E8E8E3", "cterm": "252" }
let s:white2      = { "gui": "#d8d8d3", "cterm": "250" }
let s:black       = { "gui": "#272822", "cterm": "234" }
let s:lightblack  = { "gui": "#2D2E27", "cterm": "235" }
let s:lightblack2 = { "gui": "#383a3e", "cterm": "236" }
let s:lightblack3 = { "gui": "#3f4145", "cterm": "237" }
let s:darkblack   = { "gui": "#211F1C", "cterm": "233" }
let s:grey        = { "gui": "#8F908A", "cterm": "243" }
let s:lightgrey   = { "gui": "#575b61", "cterm": "237" }
let s:darkgrey    = { "gui": "#64645e", "cterm": "239" }
let s:warmgrey    = { "gui": "#75715E", "cterm": "59" }

let s:pink        = { "gui": "#F92772", "cterm": "197" }
let s:green       = { "gui": "#3fe069", "cterm": "148" }
let s:aqua        = { "gui": "#66d9ef", "cterm": "81" }
let s:yellow      = { "gui": "#E6DB74", "cterm": "186" }
let s:orange      = { "gui": "#FD9720", "cterm": "208" }
let s:purple      = { "gui": "#ae81ff", "cterm": "141" }
let s:red         = { "gui": "#e73c50", "cterm": "196" }
let s:purered     = { "gui": "#ff0000", "cterm": "52" }
let s:darkred     = { "gui": "#5f0000", "cterm": "52" }

let s:addfg       = { "gui": "#d7ffaf", "cterm": "193" }
let s:addbg       = { "gui": "#5f875f", "cterm": "65" }
let s:delbg       = { "gui": "#f75f5f", "cterm": "167" }
let s:changefg    = { "gui": "#d7d7ff", "cterm": "189" }
let s:changebg    = { "gui": "#5f5f87", "cterm": "60" }

let s:cyan        = { "gui": "#A1EFE4" }
let s:br_green    = { "gui": "#9EC400" }
let s:br_yellow   = { "gui": "#E7C547" }
let s:br_blue     = { "gui": "#7AA6DA" }
let s:br_purple   = { "gui": "#B77EE0" }
let s:br_cyan     = { "gui": "#54CED6" }
let s:br_white    = { "gui": "#FFFFFF" }

let s:function_color = { "gui": "#f75959", "cterm": "203" }
let s:keywords_color = { "gui": "#ed095a", "cterm": "197" }
let s:separator_color = { "gui": "#ed095a", "cterm": "197" }
let s:operator_color = { "gui": "#ed095a", "cterm": "197" }

function! Get_color_palette()
  return {
    \ "white": s:white,
    \ "white2": s:white2,
    \ "black": s:black,
    \ "lightblack": s:lightblack,
    \ "lightblack2": s:lightblack2,
    \ "lightblack3": s:lightblack3,
    \ "darkblack": s:darkblack,
    \ "grey": s:grey,
    \ "lightgrey": s:lightgrey,
    \ "darkgrey": s:darkgrey,
    \ "warmgrey": s:warmgrey,
    \
    \ "pink": s:pink,
    \ "green": s:green,
    \ "aqua": s:aqua,
    \ "yellow": s:yellow,
    \ "orange": s:orange,
    \ "purple": s:purple,
    \ "red": s:red,
    \ "purered": s:purered,
    \ "darkred": s:darkred,
    \
    \ "addfg": s:addfg,
    \ "addbg": s:addbg,
    \ "delbg": s:delbg,
    \ "changefg": s:changefg,
    \ "changebg": s:changebg,
    \
    \ "cyan": s:cyan,
    \ "br_green": s:br_green,
    \ "br_yellow": s:br_yellow,
    \ "br_blue": s:br_blue,
    \ "br_purple": s:br_purple,
    \ "br_cyan": s:br_cyan,
    \ "br_white": s:br_white,
    \
    \ "function_color": s:function_color,
    \ "keywords_color": s:keywords_color,
    \ "separator_color": s:separator_color,
    \ "operator_color": s:operator_color,
  \ }
endfunction

" Statusbar
" ---------
call CHG("NormalMode", { "fg": s:black, "bg": s:aqua })
call CHG("InsertMode", { "fg": s:black, "bg": s:pink })
call CHG("ReplaceMode", { "fg": s:black, "bg": s:aqua })
call CHG("VisualMode", { "fg": s:black, "bg": s:yellow })
call CHG("CommandMode", { "fg": s:black, "bg": s:green })

call CHG("LinePosition", { "fg": s:black, "bg": s:aqua })

" Highlighting
" ------------

" editor
call CHG("Normal",        { })
call CHG("ColorColumn",   {                     "bg": s:lightblack })
call CHG("Cursor",        { "fg": s:black,      "bg": s:white })
call CHG("CursorColumn",  {                     "bg": s:lightblack2 })
call CHG("CursorLine",    {                     "bg": s:lightblack2 })
call CHG("NonText",       { "fg": s:lightgrey })
call CHG("StatusLine",    { "fg": s:warmgrey,   "bg": s:black,        "format": "reverse" })
call CHG("StatusLineNC",  { "fg": s:darkgrey,   "bg": s:warmgrey,     "format": "reverse" })
call CHG("TabLine",       { "fg": s:white,      "bg": s:darkblack,    "format": "reverse" })
call CHG("Visual",        {                     "bg": s:lightgrey })
call CHG("Search",        { "fg": s:black,      "bg": s:yellow })
call CHG("MatchParen",    { "fg": s:purple,                           "format": "underline,bold" })
call CHG("Question",      { "fg": s:yellow })
call CHG("ModeMsg",       { "fg": s:yellow })
call CHG("MoreMsg",       { "fg": s:yellow })
call CHG("ErrorMsg",      { "fg": s:black,      "bg": s:red,          "format": "standout" })
call CHG("WarningMsg",    { "fg": s:red })
call CHG("VertSplit",     { "fg": s:darkgrey,   "bg": s:darkblack })
call CHG("LineNr",        { "fg": s:grey })
call CHG("CursorLineNr",  { "fg": s:orange,     "bg": s:lightblack })
call CHG("SignColumn",    {                     "bg": s:lightblack })

" spell
call CHG("SpellBad",      { "fg": s:red,                              "format": "underline" })
call CHG("SpellCap",      { "fg": s:purple,                           "format": "underline" })
call CHG("SpellRare",     { "fg": s:aqua,                             "format": "underline" })
call CHG("SpellLocal",    { "fg": s:pink,                             "format": "underline" })

" misc
call CHG("SpecialKey",    { "fg": s:pink })
call CHG("Title",         { "fg": s:yellow })
call CHG("Directory",     { "fg": s:aqua })

" diff
call CHG("DiffAdd",       { "fg": s:addfg,      "bg": s:addbg })
call CHG("DiffDelete",    { "fg": s:black,      "bg": s:delbg })
call CHG("DiffChange",    { "fg": s:changefg,   "bg": s:changebg })
call CHG("DiffText",      { "fg": s:black,      "bg": s:aqua })

" fold
call CHG("Folded",        { "fg": s:warmgrey,   "bg": s:darkblack })
call CHG("FoldColumn",    {                     "bg": s:darkblack })
"        Incsearch"

" popup menu
call CHG("Pmenu",         { "fg": s:white2,     "bg": s:lightblack3 })
call CHG("PmenuSel",      { "fg": s:aqua,       "bg": s:lightblack3,        "format": "reverse,bold" })
call CHG("PmenuThumb",    { "fg": s:lightblack, "bg": s:grey })
"        PmenuSbar"

" Generic Syntax Highlighting
" ---------------------------
call CHG("Constant",      { "fg": s:purple })
call CHG("Number",        { "fg": s:purple })
call CHG("Float",         { "fg": s:purple })
call CHG("Boolean",       { "fg": s:purple })
call CHG("Character",     { "fg": s:yellow })
call CHG("String",        { "fg": s:yellow })

call CHG("Type",          { "fg": s:aqua })
call CHG("Structure",     { "fg": s:aqua })
call CHG("StorageClass",  { "fg": s:aqua })
call CHG("Typedef",       { "fg": s:aqua })

call CHG("Identifier",    { "fg": s:aqua })
call CHG("Function",      { "fg": s:function_color })

call CHG("Statement",     { "fg": s:pink })
call CHG("Operator",      { "fg": s:operator_color })
call CHG("Label",         { "fg": s:pink })
call CHG("Keyword",       { "fg": s:red })
call CHG("Bracket",       { "fg": s:red })

"        Conditional"
"        Repeat"
"        Exception"

call CHG("PreProc",       { "fg": s:green })
call CHG("Include",       { "fg": s:pink })
call CHG("Define",        { "fg": s:pink })
call CHG("Macro",         { "fg": s:green })
call CHG("PreCondit",     { "fg": s:green })

call CHG("Special",       { "fg": s:purple })
call CHG("SpecialChar",   { "fg": s:pink })
call CHG("Delimiter",     { "fg": s:pink })
call CHG("SpecialComment",{ "fg": s:aqua })
call CHG("Tag",           { "fg": s:pink })

"        Debug"
call CHG("Todo",          { "fg": s:orange,   "format": "bold,italic" })
call CHG("Comment",       { "fg": s:warmgrey, "format": "italic" })

call CHG("Underlined",    { "fg": s:green })
call CHG("Ignore",        {})
call CHG("Error",         { "fg": s:red, "bg": s:darkred })

" Syntastic
" ---------
hi! link SyntasticErrorSign Error
call CHG("SyntasticWarningSign",    { "fg": s:lightblack, "bg": s:orange })

" coc
" ---
hi! link CocErrorSign Error
call CHG("CocErrorHighlight",       { "fg": s:red, "format": "underline" })
call CHG("CocErrorFloat",           { "fg": s:purered, "bg": s:lightblack3 })

call CHG("CocWarningSign",          { "fg": s:orange, "bg": s:lightblack })
call CHG("CocWarningHighlight",     { "format": "underline" })
call CHG("CocWarningFloat",         { "fg": s:orange, "bg": s:lightblack3 })

call CHG("CocInfoSign",             { "fg": s:yellow, "bg": s:lightblack3 })
call CHG("CocInfoHighlight",        { "format": "underline" })

call CHG("CocHintSign",             { "fg": s:white, "bg": s:lightblack3 })
call CHG("CocHintHighlight",        { "format": "underline" })

" Terminal Colors
" ---------------
if has('nvim')
  let g:terminal_color_0  = s:black.gui
  let g:terminal_color_1  = s:red.gui
  let g:terminal_color_2  = s:green.gui
  let g:terminal_color_3  = s:yellow.gui
  let g:terminal_color_4  = s:aqua.gui
  let g:terminal_color_5  = s:purple.gui
  let g:terminal_color_6  = s:cyan.gui
  let g:terminal_color_7  = s:white.gui
  let g:terminal_color_8  = s:darkgrey.gui
  let g:terminal_color_9  = s:pink.gui
  let g:terminal_color_10 = s:br_green.gui
  let g:terminal_color_11 = s:br_yellow.gui
  let g:terminal_color_12 = s:br_blue.gui
  let g:terminal_color_13 = s:br_purple.gui
  let g:terminal_color_14 = s:br_cyan.gui
  let g:terminal_color_15 = s:br_white.gui
else
  let g:terminal_ansi_colors = [
        \ s:black.gui,
        \ s:red.gui,
        \ s:green.gui,
        \ s:yellow.gui,
        \ s:aqua.gui,
        \ s:purple.gui,
        \ s:cyan.gui,
        \ s:white.gui,
        \ s:darkgrey.gui,
        \ s:pink.gui,
        \ s:br_green.gui,
        \ s:br_yellow.gui,
        \ s:br_blue.gui,
        \ s:br_purple.gui,
        \ s:br_cyan.gui,
        \ s:br_white.gui]
endif
