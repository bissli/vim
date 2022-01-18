" => vim-fugitive
nnoremap <Leader>gb :Git blame<CR>
nnoremap <leader>gL :call GitCommand("lgs")<cr>
nnoremap <leader>gl :call GitCommand("lss")<cr>
nnoremap <Leader>gh :Silent Glog<CR>
nnoremap <Leader>gH :Silent Glog<CR>:set nofoldenable<CR>
nnoremap <Leader>gd :Gdiff<CR>

" nnoremap <silent> <leader>dp V:diffput<cr>
" nnoremap <silent> <leader>dg V:diffget<cr>
" nnoremap <silent> <Leader>df :call DiffToggle('n')<CR>
" xnoremap <silent> <Leader>df :call DiffToggle('x')<CR>
" nmap <silent> <leader>du :wincmd w<cr>:normal u<cr>:wincmd w<cr>
