let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_root_markers = ['.root', '.ctrlp']
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_files = 0
let g:ctrlp_max_height = 20
let g:ctrlp_open_multiple_files = 'h'
let g:ctrlp_extensions = ['smarttabs']

let g:ctrlp_smarttabs_modify_tabline = 1
let g:ctrlp_smarttabs_exclude_quickfix = 1

let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_funky_use_cache = 0
let g:ctrlp_funky_nolim = 1

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --smart-case --hidden -g ""'
  let g:ctrlp_use_caching = 0
elseif g:win_shell
  let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
  let g:ctrlp_clear_cache_on_exit = 0
else
  let s:ctrlp_fallback = 'find %s -type f'
  let g:ctrlp_clear_cache_on_exit = 0
endif

if has('python3') && g:os != 'Linux'
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
else
  let g:ctrlp_match_func = { 'match': 'cpsm#CtrlPMatch' }
endif
  
