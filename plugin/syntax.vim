" https://stackoverflow.com/a/4873723

" ex
" call TextEnableCodeSnip(  'c',   '@begin=c@',   '@end=c@', 'SpecialComment')
" call TextEnableCodeSnip('cpp', '@begin=cpp@', '@end=cpp@', 'SpecialComment')
" call TextEnableCodeSnip('sql', '@begin=sql@', '@end=sql@', 'SpecialComment')
" call TextEnableCodeSnip('html' ,'#{{{html' ,'#html}}}', 'SpecialComment') " for folding

func! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunc

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

func! g:CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunc
