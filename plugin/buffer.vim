func! CloseNoNameBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
    if !empty(buffers)
        silent exe 'bd '.join(buffers, ' ')
    endif
endfunc
command BufNoNameClose :call CloseNoNameBuffers() 


func! CloseHiddenBuffers()
    let visible = {}
    for t in range(1, tabpagenr('$'))
        for b in tabpagebuflist(t)
            let visible[b] = 1
        endfor
    endfor
    for b in range(1, bufnr('$'))
        if bufexists(b) && !has_key(visible, b)
            execute 'bwipeout' b
        endif
    endfor
endfun
command BufHiddenClose :call CloseHiddenBuffers() 


func! CloseBuffer()
  " Don't close window, when deleting a buffer
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunc
command BufClose :call CloseBuffer()
