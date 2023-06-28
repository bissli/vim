if PlugLoaded('fzf')

  let g:fzf_buffers_jump = 1
  let g:fzf_layout = {'down': '40%'}

  let g:fzf_action = {
      \ 'ctrl-t': 'tab drop',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit',
      \ }

  augroup fzf
    autocmd!
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
	  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler
  augroup END

  let s:fzf_command_flags = [
      \ "--smart-case ",
      \ "--nogroup ",
      \ "--hidden ",
      \ '--follow -l -m 50000 -g "" 2> /dev/null',
      \ ]
  let s:fzf_opts_flags = [
      \ "--extended ",
      \ "--ansi ",
      \ "--history=".$HOME."/.fzf_history ",
      \ "--info=inline ",
      \ "--bind ctrl-a:select-all",
      \ "--bind 'ctrl-/:toggle-preview' ",
      \ "--preview-window 'right:60%:hidden' ",
      \ "--preview 'bat --style=numbers --wrap never  --color=always --line-range :500 {}'",
      \ ]

  let $FZF_DEFAULT_COMMAND = "ag " . join(s:fzf_command_flags)
  let $FZF_DEFAULT_OPTS=join(s:fzf_opts_flags)

endif
