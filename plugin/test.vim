" => vim-test
nmap <silent> t<leader>n :TestNearest<CR>
nmap <silent> t<leader>f :TestFile<CR>
nmap <silent> t<leader>s :TestSuite<CR>
nmap <silent> t<leader>l :TestLast<CR>
nmap <silent> t<leader>g :TestVisit<CR>
let g:test#python#pytest#options = '--log-level=INFO'

