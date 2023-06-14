if executable('ag')
	set grepprg=ag\ --silent\ --vimgrep\ --nogroup\ --nocolor\ --ignore\ tags\ --smart-case\ --column
endif
if executable('rg')
	set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow
	set grepformat=%f:%l:%c:%m
endif

function! s:VSetSearch()
	let temp = @@
	norm! gvy
	let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
	let @@ = temp
endfunction

" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
function! Grep(...)
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

func! GrepDoc()
	" Search word under cursor
	silent execute "Grep ".expand('<cword>')." ".expand('%') | :cw
endfunc

func! GrepWs()
	" Search word under cursor
	silent execute "Grep ".expand('<cword>')
endfunc
