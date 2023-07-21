let g:slime_target = "tmux"
let g:slime_dont_ask_default = 1
let g:slime_default_config = {
	\ 'socket_name': get(split($TMUX, ','), 0),
	\ 'target_pane': '{top-right}' }
let g:slime_paste_file = expand($HOME . '/.slime_paste')
let g:slime_python_ipython = 1
let g:slime_no_mappings = 1
let g:slime_cell_delimiter = '^#\s*%%'

let g:ipython_cell_highlight_cells = 0
let g:ipython_cell_tag = [g:slime_cell_delimiter . '.*']
let g:ipython_cell_regex = 1 

" nmap <leader>se <Plug>SlimeLineSend
xmap <leader>se <Plug>SlimeRegionSend
" nmap <leader>sf <Plug>SlimeConfig

func! SlimeConsoleOpen()
	call system('tmux split-window -fh -p 40')
  silent execute('SlimeSend1 ' . b:key)
	call system('tmux last-pane')
endfunc

func! SlimeConsoleClose()
	silent execute('SlimeSend1 exit')
	call system('tmux last-pane')
	call system('tmux kill-pane')
endfunc

func! SlimeMappings()
  nmap <silent><leader>se :IPythonCellExecuteCellJump<CR>
  nnoremap [c :IPythonCellPrevCell<CR>
  nnoremap ]c :IPythonCellNextCell<CR>
  nnoremap <silent><leader>sl :IPythonCellClear<CR>
  nnoremap <silent><leader>sx :IPythonCellClose<CR>
  nnoremap <silent><leader>sm :IPythonCellToMarkdown<CR>
	map <F2> :call SlimeConsoleOpen()<cr>
	map <F3> :call SlimeConsoleClose()<cr>
endfunc

autocmd FileType python,r let b:key = 'ipython' | call SlimeMappings()

" python equivalent in jupytext.vim
augroup slime_syntax_cells
  au!
  " au TextChanged,TextChangedI,TextChangedP,BufWinEnter,VimEnter,BufWritePost,FileWritePost
  au BufReadPost *.R,*.r,*.py call g:SetCellHighlighting()
  au Syntax * call SyntaxRange#Include('language="R"', '\v.*(# \%\%)@=', 'r')
augroup end
