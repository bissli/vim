augroup quickfix
	autocmd!
  " Make sure that enter is never overriden in the quickfix window
  " https://superuser.com/a/815422
  autocmd BufReadPost quickfix nnoremap <buffer> <cr> <cr>
  " push quickfix window always to the bottom
  autocmd FileType qf wincmd J
augroup END

" refresh quickfix after cfdo
command! RefreshQF call setqflist(map(getqflist(), 'extend(v:val, {"text":get(getbufline(v:val.bufnr, v:val.lnum),0)})'))
