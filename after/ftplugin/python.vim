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
setl colorcolumn=88

" For python, exclude 'longest' from completeopt in order
" to prevent underscore prefix auto-completion (e.g. self.__)
" @see jedi-vim issues #429
" @see g:jedi#auto_vim_configuration
setl completeopt-=longest

" Prevent vim from removing indentation on python comments
" https://stackoverflow.com/questions/2360249/
inoremap # X<BS>#

" func! s:GetWrapLine()
    " let curr_syntax = synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name")
    " let prev_syntax = synIDattr(synIDtrans(synID(line("."), col(".")-1, 0)), "name")
    " if curr_syntax =~ 'Comment\|Constant\|String' || prev_syntax =~ 'Comment\|Constant\|String'
        " return 'nowrap'
    " endif
    " return 'wrap'
" endfunc

" aug wrapline
    " au! CursorMoved,CursorMovedI <buffer> :exe 'setlocal '.s:GetWrapLine()
" aug END
