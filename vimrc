"**************************************************************
" .vimrc

" A buffer is the in-memory text of a file
" A window is a viewport on a buffer
" A tab page is a collection of windows
"
" https://stackoverflow.com/a/26710166
"
" Abbreviations: https://stackoverflow.com/a/9312070
"**************************************************************

" Global find/replace
" :Ack foo
" :cdo s/foo/bar/g | update

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cross-Platform
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('win32') || has('win64')
    set rtp-=~/vimfiles
    set rtp^=~/.vim
    set rtp-=~/vimfiles/after
    set rtp+=~/.vim/after
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
let g:mapleader = ","

set ar
set hi=1000
set ut=100
set completeopt+=menu,popup,menuone,noselect,noinsert,longest

set nocp

au FocusGained,BufEnter,CursorHold * checktime

nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
" command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
command W w !sudo tee % > /dev/null

filetype plugin on
filetype indent on

au BufEnter * set acd

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set so=7
set wcm=<tab>
set wmnu
set wim=list:longest
set wig=*.o,*~,*.pyc,*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
set ruler
set cmdheight=2
set hid
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" search
set ic
set scs
set hls
set is

" Don't redraw while executing macros (good performance config)
"set lazyredraw
au FocusGained * :redraw!

set magic " re

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set belloff=all
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

" Put title on top of Vim
set title

" Allows leader + multiple keystrokes
set ttimeoutlen=1000

" Default to splitting below, not above
set splitbelow

" Show trailing whitespace
set listchars+=space:␣

" highlight non-ascii characters
highlight nonascii guibg=Red ctermbg=1 term=standout
au BufEnter * syntax match nonascii "[^\u0000-\u007F]"

" tab settings
if has('vim_starting')
	set ts=4 sw=4 sts=4
endif

set modifiable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable 256 colors palette
function s:auto_termguicolors()
    if !(exists("+termguicolors"))
        return
    endif

    if (&term == 'xterm-256color' || &term == 'tmux-256color')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
        set t_Co=256
    else
        set notermguicolors
    endif
endfunction
call s:auto_termguicolors()

set background=dark

try
	colorscheme inkpot
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fonts, Syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    " set guitablabel=%M\ %t
endif

" cursor options (blink insert, not on normal)
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
endif

" Set utf8 as standard encoding and en_US as the standard language
set anti enc=utf-8
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups, and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most things are in git
set nobk
set nowb
set noswf

" Vimdiff
set diffopt+=vertical,internal,algorithm:patience
if &diff
    set noreadonly
endif
" au BufWritePost * if &diff | diffupdate | endif

" Set undodir file
try
    let myundodir = expand($HOME . '/.undodir')
    call mkdir(myundodir, 'p')
    let &undodir = myundodir
    set undofile
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart tabs, Auto indent, Smart indenr
set sta
set ai
set si
set sbr=↪

""""""""""""""""""""""""""""""
" => Ack
""""""""""""""""""""""""""""""
" Change default grep behavior
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif

" Search -> quickfix window
map <leader>q :Ack

" Search word under cursor
nnoremap <leader>k :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSearch('gv', '')<CR>

" Search and replace the selected text
vnoremap <silent> <leader>r :call VisualSearch('replace', '')<CR>

" Reopen Ack search results
map <leader>gg :botright cope<cr>

" To go to the next search result
map <leader>n :cn<cr>
map <leader>] :cn<cr>

" To go to the previous search results
map <leader>p :cp<cr>
map <leader>[ :cp<cr>

" Copy tab into quickfix window
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg

" Make sure that enter is never overriden in the quickfix window
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" When you press * or # to search for the current selection
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" redraw the screen and remove any highlighting
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Smart way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" And in Vim terminal mode
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-l> <C-\><C-n><C-w>l

" Buffer management
map <silent> <leader>b :bnext<cr>
map <silent> <leader>B :bprevious<cr>
" close buffers
map <silent> <leader>bc :Bclose<cr>
map <silent> <leader>bd :Bclose<cr>
map <silent> <leader>bh :Bhidden<cr>
map <silent> <leader>bn :Bnameless<cr>
map <silent> <leader>ba :Bhidden<cr>:Bclose<cr>
" Tab management
map <silent> <leader>t :tabnext<cr>
map <silent> <leader>T :tabprevious<cr>
map <silent> <leader>tn :tabnew<cr>
map <silent> <leader>to :tabonly<cr>
map <silent> <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<cr>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files
au BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Close `No Name` buffer on inactive
au BufReadPost * :call CloseNoNameBuffers()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Clipboard
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
aug Yank
	au!
	au TextYankPost * if v:event.operator =~# '[xy]' | call WriteToSystemClipboard() | endif
	au FocusGained,BufEnter * silent! call ReadFromSystemClipboard()
aug END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NEXT
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab text
vmap <Tab> >gv
vmap <S-Tab> <gv

" Simple Ctrl+A
map <C-a> <esc>ggVG<CR>

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

"This unsets the 'last search pattern' register by hitting return
nnoremap <CR> :nohlsearch<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap Vim 0 to first non-blank character
map 0 ^

" Map scrolling with sql query buffer
noremap <Left> 20zh
noremap <Right> 20zl
noremap <Up> 20k
noremap <Down> 20j

" Resize current buffer by +/- 5
nnoremap <C-Left> :vertical resize -5<cr>
nnoremap <C-Down> :resize +5<cr>
nnoremap <C-Up> :resize -5<cr>
nnoremap <C-Right> :vertical resize +5<cr>

"Delete trailing whitespace
" fun! CleanExtraSpaces()
    " let save_cursor = getpos(".")
    " let old_query = getreg('/')
    " silent! %s/\s\+$//e
    " call setpos('.', save_cursor)
    " call setreg('/', old_query)
" endfun

" Delete trailing whitespace on save
" if has("autocmd")
	" au BufWritePre *.txt,*.py,*.js,*.sh,*.coffee :call CleanExtraSpaces()
" endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>CurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
" it deletes everything until the last slash
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Map ½ to something useful
map ½ $
cmap ½ $
imap ½ $

" Usage:
" :Rename[!] {newname}
command! -nargs=* -complete=file -bang Rename :call Rename("<args>", "<bang>")

" [t]e -> [tab]edit
cnoreabbrev <expr> e getcmdtype() == ":" && getcmdline() == 'e' ? 'edit' : 'e'
cnoreabbrev <expr> te getcmdtype() == ":" && getcmdline() == 'te' ? 'tabedit' : 'te'

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Change status line format
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%f%m%r%h\ %w\ \ dir:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ %(\ %{VisualSelectionSize()}%)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a markdown buffer for scribble
" map <leader>x :tabedit ~/buffer.md<cr>

" Quickly open a sql buffer for scribble
" map <leader>q :tabedit ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" convert Excel 4/2/20 to SQL '2020-4-2'
" s/\(\d*\)\/\(\d*\)\/\(\d*\)/'20\3-\1-\2'/g"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype Specific (see ~/.vim/ftdetect/)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable line number
au BufRead,BufNewFile *.c,*.h,*.java,*.py,*.js,*.json,*.html,*.css,*.vb,*.git,*.sql,scratch,.vimrc
    \ set nu

au FileType gitcommit call setpos('.', [0, 1, 1, 0])

" push quickfix window always to the bottom
autocmd FileType qf wincmd J

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Shell section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" os specific shell
if has('win32') || has('win64')
  set shell=powershell
  set shellcmdflag=-command
  set ff=dos
else
  set shell=/bin/bash
  set ff=unix
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Delete until the last slash
func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif

    return g:cmd_edited
endfunc

" Helper for command line smart mapping
func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

" Replace %s with current date over range, keep cursor position
" func! ReplPyDate()
    " let l:save = winsaveview()
    " let s:dt = strftime("%Y-%m-%d")
    " s/%s/\=s:dt/g
    " call winrestview(l:save)
" endfunc
" map <leader>y :call ReplPyDate()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabs & Buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! Bnameless :call CloseNoNameBuffers()
command! Bhidden :call CloseHiddenBuffers()
command! Bclose :call CloseBuffer()
command Dups :call CloseDuplicateTabs()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func URL_Decode()
   sub/%2C/,/ge
   sub/%3A/:/ge
   sub/%5B/[/ge
   sub/%7B/"/ge
   sub/%5D/]/ge
   sub/%22/'/ge
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug buffers appear in a new tab
let g:plug_window = '-tabnew'

call plug#begin('~/.vim/plugged')

" layout
Plug 'preservim/tagbar'
Plug 'ap/vim-css-color', { 'for': ['css'] }
" text
Plug 'simnalamburt/vim-mundo'
Plug 'junegunn/vim-easy-align'
Plug 'preservim/nerdcommenter'
" tmux
Plug 'christoomey/vim-tmux-navigator'
" searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'mileszs/ack.vim'
" <tab> cycle plugins
Plug 'lifepillar/vim-mucomplete'
Plug 'sirver/ultisnips'
Plug 'davidhalter/jedi-vim', { 'for': ['python'] }
" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/conflict-marker.vim'
" db
Plug 'bissli/dbext.vim', { 'for': ['python', 'sql', 'buffer'] }
" testing
Plug 'vim-test/vim-test'
" parenthesis/brackets
Plug 'tpope/vim-endwise'
Plug 'cohama/lexima.vim', { 'for': ['javascript', 'python'] }
Plug 'alvan/vim-closetag', { 'for': ['html', 'xhtml', 'phtml'] }
" r
Plug 'jalvesaq/R-Vim-runtime', { 'for': ['r'] }
" terminal
Plug 'jpalardy/vim-slime', { 'for': ['python', 'scheme', 'lisp', 'r'] }
Plug 'bhurlow/vim-parinfer', {'for': ['lisp', 'scheme'] }
" linting
Plug 'pixelneo/vim-python-docstring', { 'for': ['python'] }
Plug 'dense-analysis/ale'
" syntax
" Plug 'vim-python/python-syntax', { 'for': ['python'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }
Plug 'amadeus/vim-css', { 'for': ['css'] }
Plug 'vim-jp/vim-cpp', { 'for': ['c'] }
Plug 'bfrg/vim-cpp-modern', { 'for': ['cpp'] }
Plug 'elzr/vim-json', { 'for': ['json'] }
Plug 'PProvost/vim-ps1', { 'for': ['powershell'] }
Plug 'plasticboy/vim-markdown', { 'for': ['markdown'] }
Plug 'fatih/vim-go', { 'for': ['go'] }
Plug 'lepture/vim-jinja', { 'for': ['python', 'jinja', 'html'] }
Plug 'lifepillar/pgsql.vim', { 'for': ['sql'] }

call plug#end()
