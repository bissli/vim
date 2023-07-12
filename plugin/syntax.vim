func HighlightNonAsciiOff()
  echom "Setting non-ascii highlight off"
  syn clear nonascii
  let g:is_non_ascii_on=0
  augroup HighlightUnicode
  autocmd!
  augroup end
endfunc

func HighlightNonAsciiOn()
  echom "Setting non-ascii highlight on"
  augroup HighlightUnicode
  autocmd!
  autocmd ColorScheme *
        \ syntax match nonascii "[^\x00-\x7F]" |
        \ highlight nonascii guibg=red ctermbg=2
  augroup end
  silent doautocmd HighlightUnicode ColorScheme
  let g:is_non_ascii_on=1
endfunc

func ToggleHighlightNonascii()
  if g:is_non_ascii_on == 1
    call HighlightNonAsciiOff()
  else
    call HighlightNonAsciiOn()
  endif
endfunc

silent! call HighlightNonAsciiOff()
nnoremap <C-w>1 :call ToggleHighlightNonascii()<CR>

func! SetCellHighlighting()
  " marker: # %%
  let regex_marker = "^#\\s*%%"
  let match_marker_cmd = "syntax match CellMarker \"" . regex_marker . "\""
  let highlight_marker_cmd = "highlight CellMarker ctermfg=255 guifg=#b9b9b9 ctermbg=022 guibg=#3e3e5e cterm=bold,underline gui=bold,underline"
  if !hlexists('CellMarker')
    execute highlight_marker_cmd
  endif
  execute match_marker_cmd
  " title: [Title] 
  let regex_title = '\v(#\s*\%\%\s)@<=\[.*\]' 
  let match_title_cmd = "syntax match CellTitle \"" . regex_title . "\""
  let highlight_title_cmd = "highlight link CellTitle Comment"
  if !hlexists('CellTitle')
    execute highlight_title_cmd
  endif
  execute match_title_cmd
endfunc
