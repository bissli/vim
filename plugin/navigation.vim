""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Netrw & Tagbar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! s:GetNetrwBuffers()
    let l:names = ['NetrwTreeListing']
    return filter(copy(tabpagebuflist(tabpagenr())), {_, v -> index(l:names, bufname(v)) != -1})
endfunc

func! s:GetTagbarBuffers()
    let l:names = ['__Tagbar__']
    return filter(copy(tabpagebuflist(tabpagenr())), {_, v -> index(l:names, bufname(v)[:-3]) != -1})
endfunc

func! s:NetrwClose()
    let i = bufnr("$")
    while (i >= 1)
        if (getbufvar(i, "&filetype") == "netrw")
            silent exe "bwipeout " . i
        endif
        let i-=1
    endwhile
endfunc
command! -nargs=0 NetrwClose :call s:NetrwClose()

func! s:MyTagbarClose()
    let i = bufnr("$")
    while (i >= 1)
        if (getbufvar(i, "&filetype") == "tagbar")
            silent exe "bwipeout " . i
        endif
        let i-=1
    endwhile
endfunc
command! -nargs=0 MyTagbarClose :call s:MyTagbarClose()

func! s:NetrwOpen()
    silent Lexplore
endfunc
command! -nargs=0 NetrwOpen :call s:NetrwOpen()

func! s:ToggleNetrwAndTagbar()
    let w:jumpbacktohere = 1

    " set size and location of panes
    if exists('g:tagbar_left')
        let s:tagbar_left_user = g:tagbar_left
    else
        let s:tagbar_left_user = 0
    endif

    if exists('g:tagbar_vertical')
        let s:tagbar_vertical_user = g:tagbar_vertical
    else
        let s:tagbar_vertical_user = 0
    endif

    " settings required for split window netrw / tagbar
    let g:netrw_winsize = max([g:tagbar_width, g:netrw_winsize])
    let g:tagbar_left = 0
    let g:tagbar_vertical = winheight(0)/2

    " detect which plugins are open; toggle tagbar & Netrw
    if s:GetNetrwBuffers() != [] || s:GetTagbarBuffers() != []
        NetrwClose
        MyTagbarClose
    else
        NetrwOpen
        TagbarOpen
    endif

    " jump back to the original window
    for window in range(1, winnr('$'))
        execute window . 'wincmd w'
        if exists('w:jumpbacktohere')
            unlet w:jumpbacktohere
            break
        endif
    endfor

    " reset default / user configuration of tagbar
    let g:tagbar_left = s:tagbar_left_user
    let g:tagbar_vertical = s:tagbar_vertical_user
endfunc
command! -nargs=0 ToggleNetrwAndTagbar :call s:ToggleNetrwAndTagbar()

" when giving up
let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction
command! -nargs=0 ToggleNetrw :call ToggleNetrw()
