" => Netrw
let g:netrw_hide = 1
let g:netrw_liststyle = 3
let g:netrw_sort_options = "i"
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_sort_sequence = '[\/]$,*'
let g:netrw_winsize = -40
let g:tagbar_width = -40
au FileType netrw silent! unmap <buffer> <C-l>
au FileType netrw set nolist
noremap <silent> <c-n> :ToggleNetrw<cr>
let g:netrw_list_hide=join(['^.\+\.pyc$',
                           \'^.\+\.pyo$',
                           \'^.\+\.jpg$',
                           \'^.\+\.png$',
                           \'^.\+\.exe$',
                           \'^.\+\.class$',
                           \'^.\+\.rbc$',
                           \'^.\+\.zip$',
                           \'^.\+\.pyo$',
                           \'^.\+\.pyc$',
                           \'^.\+\.xls[xm]\=$',
                           \'^.\+\.doc[xm]\=$',
                           \'^.\+\.ppt[xm]\=$',
                           \'^.\+\.sqlite3\=$',
                           \'^.\+\.sqlite3\=$',
                           \'^\..\+\.sw.$'],
                           \',')
