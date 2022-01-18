" => fzf
let g:fzf_buffers_jump = 1
if !&diff
	au BufEnter * silent! lcd %:p:h " change cwd on enter buffer/tab
endif
let g:fzf_action = {
	  \ 'ctrl-t': 'tab drop',
	  \ 'ctrl-x': 'split',
	  \ 'ctrl-v': 'vsplit' }
augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
	\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
set ttimeoutlen=0
nnoremap <silent><c-p> :exe "FZF ".FindRootDirectory()<cr>

