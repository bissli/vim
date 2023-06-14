" fix preview window height

set previewheight=15

func! PreviewHeightWorkAround()
    if &previewwindow
        exec 'setlocal winheight='.&previewheight
    endif
endfunc

au BufEnter ?* call PreviewHeightWorkAround()
