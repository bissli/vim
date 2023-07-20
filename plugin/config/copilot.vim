let g:copilot_filetypes = {
  \ '*': v:false,
  \ 'python': v:true,
  \ }

autocmd BufReadPre *
   \ let f=getfsize(expand("<afile>"))
   \ | if f > 100000 || f == -2
   \ | let b:copilot_enabled = v:false
   \ | endif

let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
imap <silent> <C-\> <Plug>(copilot-dismiss)
