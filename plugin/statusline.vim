func! VisualSelectionSize()
    let m = mode()
    if m !~# "[vV\<C-v>]"
        return ''
    endif
    let lines = getregion(getpos('v'), getpos('.'), {'type': m})
    if empty(lines)
        return ''
    endif
    let nlines = len(lines)
    if m ==# 'v'
        let nchars = 0
        for l in lines
            let nchars += strcharlen(l)
        endfor
        if nlines == 1
            return 'Sel: ' . nchars . ' chars'
        endif
        return printf('Sel: %d lines, %d chars', nlines, nchars)
    elseif m ==# 'V'
        return 'Sel: ' . nlines . ' lines'
    else
        let ncols = 0
        for l in lines
            let ncols = max([ncols, strcharlen(l)])
        endfor
        return printf('Sel: Block %dx%d', nlines, ncols)
    endif
endfunc

func! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunc

func! TokenCountStatusSafe()
    if exists('*TokenCountStatus')
        return TokenCountStatus()
    endif
    return ''
endfunc

let &statusline = ' %{HasPaste()}%f%m%r%h %w  dir: %r%{getcwd()}%h   Line: %l %( %{VisualSelectionSize()}%)%=%{TokenCountStatusSafe()} '
