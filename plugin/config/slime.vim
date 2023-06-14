let g:slime_target = "tmux"
let g:slime_dont_ask_default = 1
" let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_default_config = {
	\ 'socket_name': get(split($TMUX, ','), 0),
	\ 'target_pane': '{top-right}' }
let g:slime_paste_file = expand($HOME . '/.slime_paste')
let g:slime_bracketed_paste = 1
let g:slime_no_mappings = 1
let g:slime_cell_delimiter = "^#\\s*%%"

" nmap <leader>se <Plug>SlimeLineSend
" xmap <leader>se <Plug>SlimeRegionSend
" nmap <leader>sf <Plug>SlimeConfig

func! g:QtConsoleStart()
	call system('tmux split-window -fh -p 40')
	silent execute('SlimeSend1 ipython')
	call system('tmux last-pane')
endfunc

" func! g:QtconsoleStart()
" 	" (sample automation): if matchstr(trim(system('tmux has-session -t jconsole')), 'jconsole')

" 	" persistent console session
" 	call system('tmux has-session -t jconsole || tmux new-session -d -s jconsole')
" 	call system('tmux send -t "jconsole:.1" "cd ' . expand(getcwd()) . '" ENTER')
" 	call system('tmux send -t "jconsole:.1" "jupyter console" ENTER')
" 	" jupyter qtconsole session
" 	call system('tmux has-session -t qtconsole || tmux new-session -d -s qtconsole')
" 	call system('tmux send -t "qtconsole:.1" "cd ' . expand(getcwd()) . '" ENTER')
" 	call system('tmux send -t "qtconsole:.1" "jupyter qtconsole --existing" ENTER')
" 	" connect
" 	let timer = timer_start(1000, 'JConnect', {})
" 	func! JConnect(timer)
" 		silent execute('JupyterConnect')
" 	endfunc
" endfunc

func! g:QtConsoleQuit()
	silent execute('SlimeSend1 exit')
	call system('tmux last-pane')
	call system('tmux kill-pane')
endfunc

func! SlimePyMappings()
	nmap <silent><leader>se <Plug>SlimeCellsSendAndGoToNext
	map <F2> :call QtConsoleStart()<cr>
	map <F3> :call QtConsoleQuit()<cr>
endfunc

func! SlimeRMappings()
	nmap <silent><leader>se <Plug>SlimeCellsSendAndGoToNext
endfunc

au BufRead,BufNewFile *.ipynb set filetype=python
autocmd FileType python call SlimePyMappings()
autocmd FileType r call SlimeRMappings()
