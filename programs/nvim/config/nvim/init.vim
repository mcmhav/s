set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua require'nvim-treesitter.configs'.setup{highlight={enable=true},ensure_installed={"python","kdl"}}

TermOpen * setlocal nonumber norelativenumber
