""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabs & Buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! GitCommand(command)
  silent! !clear
  exec "!git " . a:command . " %"
endfunc

func! DiffToggle(mode) range
    if &diff
        diffoff
    else
        if a:mode=='x'
            call linediff#Linediff(a:firstline, a:lastline)
        else
            diffthis
        endif
    endif
endfunc
