""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabs & Buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Close empty buffers
func! CloseNoNameBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
    if !empty(buffers)
        silent exe 'bd '.join(buffers, ' ')
    endif
endfunc

" Close hidden buffers
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

" Don't close window, when deleting a buffer
func! CloseBuffer()
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

" Close duplicate open tabs
func CloseDuplicateTabs()
	let cnt = 0
	let i = 1
	let tpbufflst = []
    let dups = []
	let tabpgbufflst = tabpagebuflist(i)
	while type(tabpagebuflist(i)) == 3
		if index(tpbufflst, tabpagebuflist(i)) >= 0
			call add(dups, i)
		else
			call add(tpbufflst, tabpagebuflist(i))
		endif

		let i += 1
		let cnt += 1
	endwhile

    call reverse(dups)

	for tb in dups
		exec "tabclose ".tb
	endfor
endfunc

" Store copy of temporary buffer
func! FlushTempBuffer()
    let fname = "scratch_".strftime("%Y%m%d_%H%M%S")
    exe ":!find ~/.vim/scratch -size +0 -print0 | xargs -0 -I % cp % ~/.vim/temp_dirs/scratch/" . fname
    " !> ~/.vim/scratch
endfunc

func! Scratch()
    split
    noswapfile hide enew
    setlocal buftype=nofile
    setlocal bufhidden=hide
    "setlocal nobuflisted
    "lcd ~
    file scratch
endfunc

" Rename a buffer within Vim and on disk.
func! Rename(name, bang)
    let l:curfile = expand("%:p")
    let l:curfilepath = expand("%:p:h")
    let l:newname = l:curfilepath . "/" . a:name
    let v:errmsg = ""
    silent! exec "saveas" . a:bang . " " . fnameescape(l:newname)
    if v:errmsg =~# '^$\|^E329'
        if expand("%:p") !=# l:curfile && filewritable(expand("%:p"))
            silent exec "bwipe! " . fnameescape(l:curfile)
            if delete(l:curfile)
                echoerr "Could not delete " . l:curfile
            endif
        endif
    else
        echoerr v:errmsg
    endif
endfunc
