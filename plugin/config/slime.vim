let g:slime_target = "tmux"
let g:slime_dont_ask_default = 1
let g:slime_default_config = {
	\ 'socket_name': get(split($TMUX, ','), 0),
	\ 'target_pane': '{top-right}' }
let g:slime_paste_file = expand($HOME . '/.slime_paste')
let g:slime_python_ipython = 1
let g:slime_no_mappings = 1
let g:slime_cell_delimiter = "^#\\s*%%"

let g:ipython_cell_send_cell_headers = 1
let g:ipython_cell_highlight_cells = 0
let g:ipython_cell_regex = g:slime_cell_delimiter

" nmap <leader>se <Plug>SlimeLineSend
xmap <leader>se <Plug>SlimeRegionSend
" nmap <leader>sf <Plug>SlimeConfig

func! g:OpenIpython()
	call system('tmux split-window -fh -p 40')
	silent execute('SlimeSend1 ipython')
	call system('tmux last-pane')
endfunc

func! g:CloseIpython()
	silent execute('SlimeSend1 exit')
	call system('tmux last-pane')
	call system('tmux kill-pane')
endfunc

func! SlimePyMappings()
  nmap <silent><leader>se :IPythonCellExecuteCellJump<CR>
  nnoremap [c :IPythonCellPrevCell<CR>
  nnoremap ]c :IPythonCellNextCell<CR>
  nnoremap <silent><leader>sc :IPythonCellClear<CR>
  nnoremap <silent><leader>sx :IPythonCellClose<CR>
	map <F2> :call OpenIpython()<cr>
	map <F3> :call CloseIpython()<cr>
endfunc

au BufRead,BufNewFile *.ipynb set filetype=python
autocmd FileType python call SlimePyMappings()
