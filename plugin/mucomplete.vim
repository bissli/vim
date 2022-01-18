" => vim-mucomplete
" set completeopt-=preview

augroup OmniCompletionSetup
    autocmd!
    autocmd FileType c          set omnifunc=ccomplete#Complete
    autocmd FileType python     set omnifunc=jedi#completions
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType markdown   set omnifunc=htmlcomplete#CompleteTags
augroup END

let g:mucomplete#chains = {}
let g:mucomplete#chains.default  = ['omni', 'tags', 'keyn', 'keyp', 'path']
let g:mucomplete#chains.python = ['ulti', 'omni', 'keyn', 'keyp']
let g:mucomplete#chains.vim = ['incl', 'cmd']
let g:mucomplete#chains.sql = ['omni', 'dict']
set dictionary+=~/dict.txt

" Do the mappings myself
let g:mucomplete#no_mappings = 1

" Extend completion
imap <expr> <S-tab> mucomplete#extend_fwd("\<right>")

" Cycle through completion chains
imap <unique> <c-'> <plug>(MUcompleteCycFwd)
imap <unique> <c-;> <plug>(MUcompleteCycBwd)

