" => UltiSnips
let g:UltiSnipsSnippetsDir=$HOME.".vim/ultisnips"
let g:UltiSnipsSnippetDirectories=["ultisnips"]
let g:UltiSnipsExpandTrigger="<C-right>"
let g:UltiSnipsJumpForwardTrigger="<C-right>"
let g:UltiSnipsJumpBackwardTrigger="<C-left>"
au Filetype snippets setl noet " requires explicit tab

" Pair ultisnips and mucomplete
fun! TryUltiSnips()
    let g:ulti_expand_or_jump_res = 0
    if !pumvisible() " With the pop-up menu open, let Tab move down
        call UltiSnips#ExpandSnippetOrJump()
    endif
    return ''
endf

fun! TryMUcomplete()
    return g:ulti_expand_or_jump_res ? "" : "\<plug>(MUcompleteFwd)"
endf

" Try to expand snippet, if fails try completion
inoremap <plug>(TryUlti) <c-r>=TryUltiSnips()<cr>
imap <expr> <silent> <plug>(TryMU) TryMUcomplete()
imap <expr> <silent> <tab> "\<plug>(TryUlti)\<plug>(TryMU)"

" Map tab in select mode as well, otherwise you won't be able to jump if
" a snippet place holder has default value.
snoremap <silent> <tab> <Esc>:call UltiSnips#ExpandSnippetOrJump()<cr>

" Autoexpand if completed keyword is a snippet
inoremap <silent> <expr> <plug>MyCR mucomplete#ultisnips#expand_snippet("\<cr>")
imap <cr> <plug>MyCR
