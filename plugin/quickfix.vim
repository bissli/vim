augroup quickfix
	autocmd!
  " make modifiable
  autocmd BufReadPost quickfix set ma
  " quick close with q
  autocmd BufWinEnter quickfix nnoremap <silent><buffer>q :cclose<cr>:lclose<cr>
  " Make sure that enter is never overriden in the quickfix window
  " https://superuser.com/a/815422
  autocmd BufReadPost quickfix nnoremap <buffer> <cr> <cr>
  " push quickfix window always to the bottom
  autocmd FileType qf wincmd J
  " shorten filenames on grep
  autocmd QuickFixCmdPost cgetexpr,lgetexpr call setqflist(ShortenPathsInList(getqflist()))
augroup END

func! ShortenPathsInList(list)
    let index = 0
    while index < len(a:list)
        let item = a:list[index] " dict
        let filepath = bufname(item["bufnr"])
        let item["module"] = pathshorten(filepath, 1)
        let index = index + 1
    endwhile
    return a:list
endfunc
