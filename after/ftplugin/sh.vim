" after/ftplugin/sh.vim - Shell script indentation settings
" These settings enforce EditorConfig rules for shell files
" According to ~/.editorconfig lines 55-58:
"   [{.profile,.bash*,.zsh*,profile,*.bashrc,*.sh}]
"   indent_style = space
"   indent_size = 4
"   tab_width = 4

setlocal expandtab      " Use spaces instead of tabs
setlocal tabstop=4      " Tab width is 4 spaces
setlocal shiftwidth=4   " Indent width is 4 spaces
setlocal softtabstop=4  " Backspace deletes 4 spaces
