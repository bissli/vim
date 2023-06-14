"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
setl shiftwidth=4
setl tabstop=4
setl softtabstop=0
setl fileformat=unix
setl expandtab
setl linebreak
setl smarttab
setl nolisp
setl nowrap

" For python, exclude 'longest' from completeopt in order
" to prevent underscore prefix auto-completion (e.g. self.__)
" @see jedi-vim issues #429
" @see g:jedi#auto_vim_configuration
setl completeopt-=longest

" Prevent vim from removing indentation on python comments
" https://stackoverflow.com/questions/2360249/
inoremap # X<BS>#

" Text width
setl colorcolumn=119
setl textwidth=119
let g:pep8_text_width=119
let g:pep8_comment_text_width=88

aug pep8textwidth
  au! CursorMoved,CursorMovedI <buffer> :exe 'setlocal textwidth='.s:GetCurrentTextWidth()
aug END

" aug wrapline
    " au! CursorMoved,CursorMovedI <buffer> :exe 'setlocal '.s:GetWrapLine()
" aug END

" Return appropriate textwidth for cursor position (leverages syntax engine)
func! s:GetCurrentTextWidth()
    let curr_syntax = synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name")
    let prev_syntax = synIDattr(synIDtrans(synID(line("."), col(".")-1, 0)), "name")
    if curr_syntax =~ 'Comment\|Constant\|String' || prev_syntax =~ 'Comment\|Constant\|String'
        return g:pep8_comment_text_width
    endif
    return g:pep8_text_width
endfunc

" func! s:GetWrapLine()
    " let curr_syntax = synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name")
    " let prev_syntax = synIDattr(synIDtrans(synID(line("."), col(".")-1, 0)), "name")
    " if curr_syntax =~ 'Comment\|Constant\|String' || prev_syntax =~ 'Comment\|Constant\|String'
        " return 'nowrap'
    " endif
    " return 'wrap'
" endfunc
