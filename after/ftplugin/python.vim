"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => general
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
setl colorcolumn=79

" For python, exclude 'longest' from completeopt in order
" to prevent underscore prefix auto-completion (e.g. self.__)
" @see jedi-vim issues #429
" @see g:jedi#auto_vim_configuration
setl completeopt-=longest

" Prevent vim from removing indentation on python comments
" https://stackoverflow.com/questions/2360249/
inoremap # X<BS>#

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => wrapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" aug wrapline
    " au! CursorMoved,CursorMovedI <buffer> :exe 'setlocal '.s:GetWrapLine()
" aug END

func! s:GetWrapLine()
    let curr_syntax = synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name")
    let prev_syntax = synIDattr(synIDtrans(synID(line("."), col(".")-1, 0)), "name")
    if curr_syntax =~ 'Comment\|Constant\|String' || prev_syntax =~ 'Comment\|Constant\|String'
        return 'nowrap'
    endif
    return 'wrap'
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => context-aware textwidth (from vim-pep8-text-width)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:py_code_text_width=79
let g:py_comment_text_width=72
let g:py_string_text_width=119

augroup pep8textwidth
  autocmd! CursorMoved,CursorMovedI <buffer> :exe 'setlocal textwidth='.s:GetCurrentTextWidth()
augroup END

" Return appropriate textwidth for cursor position (leverages syntax engine).
function! s:GetCurrentTextWidth()
    " - comments should be 70 characters, simple enough as entire line is a
    " comment
    " - string issue at 70 characters is that it wraps down to the next line
    let r = line(".")
    let c = col(".")
    let curr_syntax = synIDattr(synIDtrans(synID(r, c, 0)), "name")
    let prev_syntax = synIDattr(synIDtrans(synID(r, c-1, 0)), "name")
    " let next_syntax = synIDattr(synIDtrans(synID(r, c+1, 0)), "name")
    " let above_syntax = synIDattr(synIDtrans(synID(r-1, c, 0)), "name")
    " let below_syntax = synIDattr(synIDtrans(synID(r+1, c, 0)), "name")
    " echom "[" . above_syntax . "],[" . prev_syntax . "],[" . curr_syntax . "],[". next_syntax . "],[" . below_syntax . "]"
    if curr_syntax =~ 'Comment\|Todo' || prev_syntax =~ 'Comment\|Todo'
        return g:py_comment_text_width
    elseif curr_syntax =~ 'String' || prev_syntax =~ 'String'
        return g:py_string_text_width
    else
      return g:py_code_text_width
    endif
endfunction
