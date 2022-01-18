""""""""""""""""""""""""""""""
" => Clipboard related
""""""""""""""""""""""""""""""
set clipboard^=unnamed,unnamedplus

" Mappings to yank/paste to/from system clipboard
" func! GetSelectedText()
    " normal gv"xy
    " let result = getreg("x")
    " return result
" endfunc
" if $OSVERSION == 'WSL' && executable("clip.exe")
    " " https://stackoverflow.com/questions/44480829/how-to-copy-to-clipboard-in-vim-of-bash-on-windows/44480918
    " noremap <leader>y :call system('clip.exe', GetSelectedText())<CR>
    " noremap <leader>x :call system('clip.exe', GetSelectedText())<CR>gvx
    " noremap <leader>v :exe 'norm i' . system('paste.exe')<CR>
" " elseif has("clipboard")
    " " edit these later (remove most likely)
    " vnoremap <C-Y> "+y
    " vnoremap <C-Insert> "+y
    " vnoremap <C-X> "+x
    " vnoremap <S-Del> "+x
    " map <C-V>       "+gP
    " map <S-Insert>      "+gP
    " cmap <C-V>      <C-R>+
    " cmap <S-Insert>     <C-R>+
" else
    " vmap <leader>y !xsel -i -b && xsel -b <CR>
    " nmap <leader>p :r !xsel -b <CR>
	" Map ,y/p to yank/paste to/from system clipboard
	" map <leader>y "+y
	" map <leader>p "+p
" endif

""""""""""""""""""""""""""""""
" => system clipboard
""""""""""""""""""""""""""""""
let g:systemclipboard_path = "/" . join(split(fnamemodify(resolve(expand('<sfile>:p')), ':h'), "/")[:-3], "/") . '/scripts/clipboard.py'


function! WriteToSystemClipboard()
python3 <<EOF
import sys
sys.argv = ['write']
EOF
	execute 'py3file ' . g:systemclipboard_path
    echom "system-clipboard: yanked"
endfunction

function! ReadFromSystemClipboard()
python3 <<EOF
import sys
sys.argv = ['read']
EOF
	execute 'py3file ' . g:systemclipboard_path
    echom "system-clipboard: ready to put"
endfunction

command WriteToSystemClipboard call WriteToSystemClipboard()
command ReadFromSystemClipboard call ReadFromSystemClipboard()
