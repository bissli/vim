if executable("rg")
	  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow
    set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable("ag")
	  set grepprg=ag\ --silent\ --vimgrep\ --nogroup\ --nocolor\ --smart-case\ --column\ $*
    set grepformat=%f:%l:%c:%m
else
    let &grepprg='grep -n -r --exclude=' . shellescape(&wildignore) . ' $* .'
endif

function! s:VSetSearch()
	let temp = @@
	norm! gvy
	let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
	let @@ = temp
endfunction

" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
function! Grep(...)
  let s:command = join([&grepprg] + [expandcmd(join(a:000, ' '))], ' ')
  return system(s:command)
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

augroup quickfix 
	autocmd!
  " q to quit the quickfix list
  autocmd BufWinEnter quickfix nnoremap <silent><buffer>q :cclose<cr>:lclose<cr>
  " Make sure that enter is never overriden in the quickfix window
  " https://superuser.com/a/815422
  autocmd BufReadPost quickfix nnoremap <buffer> <cr> <cr>
  " push quickfix window always to the bottom
  autocmd FileType qf wincmd J
  " grep to quickfix
	autocmd QuickFixCmdPost cgetexpr cwindow 
        \| call setqflist([], 'a', {'title': ':' . s:command})
        \| call setqflist(ShortenPathsInList(getqflist()))
  " grep to location list
  autocmd QuickFixCmdPost lgetexpr lwindow 
        \| call setloclist(0, [], 'a', {'title': ':' . s:command})
augroup END

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

func! GrepDoc()
	" Search word under cursor
	silent! execute "Grep ".expand('<cword>')." ".expand('%') | :cw
endfunc

func! GrepWs()
	" Search word under cursor
	silent! execute "Grep ".expand('<cword>'). " " .FindRootDirectory()
endfunc

func! ShortenPathsInList(list)
    let index = 0
    while index < len(a:list)
        let item = a:list[index] " dict
        let filepath = bufname(item["bufnr"])
        let item["module"] = pathshorten(filepath, 1)
        let index = index + 1
    endwhile
    return a:list
endfunc

