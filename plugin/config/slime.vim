let g:slime_target = "vimterminal"
let g:slime_vimterminal_config = {"term_finish": "close"}
let g:slime_paste_file = expand($HOME . '/.slime_paste')
let g:slime_no_mappings = 1
let g:slime_cell_delimiter = "^#\\s*%%"
let g:slime_cells_no_highlight = 1

au FileType javascript let b:slime_vimterminal_cmd = "node"
au FileType julia let b:slime_vimterminal_cmd = "julia"
au FileType python let b:slime_vimterminal_cmd = "ipython"
au FileType r let b:slime_vimterminal_cmd = "r"

func! g:Notebook()
  " persistent console session
  call system('tmux has-session -t notebook || tmux new-session -d -s notebook')
  call system('tmux send -t "notebook:.1" "cd ' . expand(getcwd()) . '" ENTER')
  call system('tmux send -t "notebook:.1" "nohup jupyter notebook --no-browser &> /tmp/nohup-notebook.out &" ENTER')
endfunc
command! -nargs=0 Notebook :call Notebook()

func! SlimeMappings()
  " set up mapping
	nmap <silent><leader>se <Plug>SlimeCellsSendAndGoToNext
  xmap <silent><leader>se <Plug>SlimeRegionSend
  nmap <silent><leader>sc <Plug>SlimeConfig
	nmap <silent><leader>t :botright vert term ++close<cr>ipython<cr>%clear<cr><C-w><C-w><Plug>SlimeConfig
endfunc

au FileType javascript,julia,python,r call SlimeMappings()

