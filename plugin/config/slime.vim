let g:slime_target = "vimterminal"
let g:slime_vimterminal_config = {"term_finish": "close"}
let g:slime_paste_file = expand($HOME . '/.slime_paste')
let g:slime_no_mappings = 1
let g:slime_cell_delimiter = "^#\\s*%%"

au FileType javascript let b:slime_vimterminal_cmd = "node"
au FileType julia let b:slime_vimterminal_cmd = "julia"
au FileType python let b:slime_vimterminal_cmd = "ipython"
au FileType r let b:slime_vimterminal_cmd = "r"

func! SlimeMappings()
	nmap <silent><leader>se <Plug>SlimeCellsSendAndGoToNext
  xmap <silent><leader>se <Plug>SlimeRegionSend
	nmap <silent><leader>t :botright vert term ++close<cr>ipython<cr>%clear<cr><C-w><C-w><Plug>SlimeConfig
endfunc

au FileType javascript,julia,python,r call SlimeMappings()
