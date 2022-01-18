" => jedi-vim
let g:pymode_rope = 0
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#show_call_signatures = 0
let g:jedi#show_call_signatures_delay = 0
autocmd FileType python call jedi#configure_call_signatures()

