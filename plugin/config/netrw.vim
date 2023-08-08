" => Netrw
" tree style-listing
let g:netrw_liststyle = 3
let g:netrw_sort_options = "i"
" disable banner
let g:netrw_banner = 0
" human-readable file sizes
let g:netrw_sizestyle = "H"
" act like "P" (i.e. open previous window) when opening split
let g:netrw_browse_split = 4
" show hidden files
let g:netrw_hide = 1
" keep the current directory and the browsing directory synced
let g:netrw_keepdir = 0
" show directories first
let g:netrw_sort_sequence = '[\/]$,*'
let g:netrw_winsize = -40
let g:tagbar_width = -40
let g:NetrwIsOpen = 0
" let g:netrw_list_hide = &wildignore
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
au FileType netrw silent! unmap <buffer> <C-l>
au FileType netrw set nolist

function! ToggleNetrw()
  if g:NetrwIsOpen
    let i = bufnr("$")
    while (i >= 1)
      if (getbufvar(i, "&filetype") == "netrw")
        silent exe "bwipeout " . i
      endif
      let i-=1
    endwhile
    let g:NetrwIsOpen = 0
  else
    let g:NetrwIsOpen = 1
      silent Lex!
  endif
endfunction
command! -nargs=0 ToggleNetrw :call ToggleNetrw()

noremap <silent><c-n> :ToggleNetrw<cr>
