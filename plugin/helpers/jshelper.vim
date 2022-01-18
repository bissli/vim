"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => javascript util 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

func! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    func! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunc
    setl foldtext=FoldText()
endfunc
