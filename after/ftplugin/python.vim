"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => general
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
setl shiftwidth=4
setl tabstop=4
setl softtabstop=0
setl fileformat=unix
setl expandtab
setl nosmartindent
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
let g:python_normal_text_width=88
let g:python_comment_text_width=72
let g:python_docstring_text_width=79
let g:python_string_text_width=119

function! GetPythonTextWidth()
    let cur_syntax = synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name")

    if cur_syntax == "Comment"
        return g:python_comment_text_width
    endif

    if cur_syntax == "String"
        " Check to see if we're in a docstring
        if match(getline(line(".")), "^\\s*\\('''\\|\"\"\"\\)") == 0
            return g:python_docstring_text_width
        else
            return g:python_string_text_width
        endif
    endif

    return g:python_normal_text_width
endfunction

augroup pep8textwidth
    au!
    autocmd CursorMoved,CursorMovedI * :if &ft == 'python' | :exe 'setlocal textwidth='.GetPythonTextWidth() | :endif
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => smart line join
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PythonSmartJoin()
    normal! gvJ
    let l:line = getline('.')
    let l:cleaned = substitute(l:line, '\([({\[]\) ', '\1', 'g')
    let l:cleaned = substitute(l:cleaned, ' \([]})]\)', '\1', 'g')
    call setline('.', l:cleaned)
endfunction

xnoremap <buffer> <silent> J :<C-u>call PythonSmartJoin()<CR>
