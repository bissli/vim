"=============================================================================
let s:k_version = 001
"=============================================================================

" Avoid global reinclusion {{{1
if &cp || (exists("g:loaded_config_buffer") && !exists('g:force_reload_config_buffer'))
  finish
endif
let g:loaded_config_tabs = s:k_version
let s:cpo_save=&cpo
set cpo&vim
" Avoid global reinclusion }}}1
"------------------------------------------------------------------------
" Commands and Mappings {{{1
command BufClose :call CloseBuffer()
command BufNoNameClose :call CloseNoNameBuffers() 
command BufHiddenClose :call CloseHiddenBuffers() 

nnoremap <silent><expr> <Plug>CycleToNextBuffer (&ft=='qf' ? ":cnewer" : <sid>CycleToNext('after'))."\<CR>"
nnoremap <silent><expr> <Plug>CycleToPreviousBuffer (&ft=='qf' ? ":colder" : <sid>CycleToNext('before'))."\<CR>"

if !&diff
  au BufEnter * silent! lcd %:p:h " change cwd on enter buffer/tab
endif
" Commands and Mappings }}}1
"------------------------------------------------------------------------
" Functions {{{1
func! CloseNoNameBuffers()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
  if !empty(buffers)
    silent exe 'bd '.join(buffers, ' ')
  endif
endfunc

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

" from https://github.com/LucHermitte/lh-misc/blob/master/plugin/next-undisplayed-buffer.vim
function! s:CycleToNext(direction) abort
  let undisplayed_buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && bufwinnr(v:val) == -1')
  if empty(undisplayed_buffers)
    return ":buffer"
  endif
  if a:direction == 'next'
    let after = filter(copy(undisplayed_buffers), 'v:val > bufnr("%")')
    let buf = empty(after) ? undisplayed_buffers[0] : after[0]
  else
    let before = filter(copy(undisplayed_buffers), 'v:val < bufnr("%")')
    let buf = empty(before) ? undisplayed_buffers[-1] : before[-1]
  endif
  return ':b '.buf
endfunction

" Functions }}}1
"------------------------------------------------------------------------
let &cpo=s:cpo_save
"=============================================================================
" vim600: set fdm=marker:
