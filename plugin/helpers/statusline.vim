
func! VisualSelectionSize()
    if mode() == "v"
        " Exit and re-enter visual mode, because the marks
        " ('< and '>) have not been updated yet.
        exe "normal \<ESC>gv"
        if line("'<") != line("'>")
            return 'Lines: ' . (line("'>") - line("'<") + 1)
        else
            return 'Chars: ' . (col("'>") - col("'<") + 1)
        endif
    elseif mode() == "V"
        exe "normal \<ESC>gv"
        return (line("'>") - line("'<") + 1) . ' lines'
    elseif mode() == "\<C-V>"
        exe "normal \<ESC>gv"
        return 'Block: ' . (line("'>") - line("'<") + 1) . 'x' . (abs(col("'>") - col("'<")) + 1)
    else
        return ''
    endif
endfunc


" Helper for status line
func! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunc
