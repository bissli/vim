" => vim-slime
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_dont_ask_default = 1
au Filetype python,lisp,r,scheme xmap <buffer> <leader>se <Plug>SlimeRegionSend
au Filetype python,lisp,r,scheme nmap <buffer> <leader>se <Plug>SlimeParagraphSend

