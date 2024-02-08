" Single doctest
fun! DoctestFunction()
    " Find function under cursor
    let l:save = winsaveview()
    normal [[
    let l:fun = substitute(getline('.'), 'def \(\w*\)(.*', '\1', '')
    execute ':!python3 % ' . l:fun
    call winrestview(l:save)
endfun

augroup python_test
    autocmd!
    autocmd Filetype python nnoremap <leader>zt :call TestFunction()<cr>
augroup end
