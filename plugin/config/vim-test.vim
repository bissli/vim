let test#strategy = 'vimux'
let g:VimuxHeight = '40'
let g:VimuxUseNearest = 0
let g:VimuxCloseOnExit = 1

nmap <silent><leader>zn :TestNearest<CR>
nmap <silent><leader>zp :TestFile<CR>
nmap <silent><leader>zs :TestSuite<CR>
nmap <silent><leader>zl :TestLast<CR>
nmap <silent><leader>zv :TestVisit<CR>
" nmap <silent><leader>zt -> run doctest for function under cursor
