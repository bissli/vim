" Set local foldmarker
" vim:fdm=marker

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

" ---------------------------------------------------------------
" Configure Directories
" ---------------------------------------------------------------
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$HOME/_vim,$HOME/vimfiles,$VIMRUNTIME
else
  set runtimepath=$HOME/.vim,$VIMRUNTIME
endif

" ---------------------------------------------------------------
" OS Detection
" ---------------------------------------------------------------
runtime plugin/platform.vim
call platform#detect()

" ---------------------------------------------------------------
" Load vim files
" ---------------------------------------------------------------
runtime plug.vim

" ---------------------------------------------------------------
" General config
" ---------------------------------------------------------------
set nocompatible                                                         | " disable legacy compatibility
set encoding=utf-8                                                       | " Set utf8 as standard encoding
set fileencoding=utf-8                                                   | " Set utf8 as standard encoding
set fileformats=unix,dos,mac                                             | " Use Unix as the standard file type
set autoread                                                             | " Reload files changed outside vim
set history=1000                                                         | " Store lots of :cmdline history
set updatetime=100                                                       | " ??
set previewheight=15
set noswapfile                                                           | " No swap file
set nobackup                                                             | " No backup
set nowb                                                                 | " No write-backup
set nowrap                                                               | " Do not wrap by default
set shortmess+=c                                                         | " Suppress completion menu messages
set laststatus=2                                                         | " Alawys show statusline
set wildcharm=<tab>
set wildmode=list:longest
set wildignore=*.o,*~,*.pyc,*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
set cmdheight=1                                                          | " Descrease bottom command window margin
set hidden                                                               | " Allow buffers to exist in the background
set whichwrap+=<,>,h,l
set backspace=indent,eol,start
set magic                                                                | " re
set ruler                                                                | " show the cursor position all the time
set showmatch                                                            | " Briefly jump to a paren once it's balanced
set matchtime=2                                                          | " (for only .2 seconds)
set noerrorbells                                                         | " No sounds
set novisualbell                                                         | " No sounds
set belloff=all                                                          | " No sounds
set t_vb=
set ttimeout                                                             | " time out for key codes
set ttimeoutlen=500                                                      | " Allows leader + multiple keystrokes
set foldcolumn=0                                                         | " Remove left margin
set title                                                                | " Put title on top of Vim
set splitbelow                                                           | " Default to splitting below, not above
set listchars+=space:␣                                                   | " Show trailing whitespace
set foldmethod=marker                                                    | " Placeholder
set nofoldenable                                                         | " Disable folding
set display=truncate                                                     | " Show @@@ in the last line if it is truncated.
set autoindent
set smartindent
set scrolloff=5                                                          | " Show a few lines of context around the cursor.
set smarttab
set showbreak=->
set hlsearch
set ignorecase                                                           | " Ignore case by default when searching
set smartcase                                                            | " Switch to case sensitive mode if needle contains uppercase characters
set incsearch                                                            | " Do incremental searching when it's possible to timeout.
set number                                                               | " Always enable line numbers
set nrformats-=octal                                                     | " Do not recognize octal numbers for Ctrl-A and Ctrl-X
if !has('nvim')
  set completeopt+=menu,popup,menuone,noselect,noinsert,longest          | " Complete options
endif

" Because I press this all the time
command W w

" :S sudo saves the file
" (useful for handling the permission-denied error)
" command! S execute 'w !sudo tee % > /dev/null' <bar> edit!
command S w !sudo tee % > /dev/null

" ---------------------------------------------------------------
" Leader
" ---------------------------------------------------------------
let mapleader = ","
let g:mapleader = ","

" ---------------------------------------------------------------
" Colors
" ---------------------------------------------------------------

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " Highlight strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

" Enable 256 colors palette
function s:auto_termguicolors()
    if !(exists("+termguicolors"))
        return
    endif
    if &term =~ '\v(tmux|screen|xterm)-256color'
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
        set t_Co=256
    else
        set notermguicolors
    endif
endfunction
call s:auto_termguicolors()

try
    colorscheme inkpot
catch
endtry

set background=dark

" ---------------------------------------------------------------
" Fonts, Syntax
" ---------------------------------------------------------------
" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=t
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

" Vimdiff
set diffopt+=vertical,internal,algorithm:patience
if &diff | set noreadonly | endif

" au BufWritePost * if &diff | diffupdate | endif

" highlight non-ascii characters
augroup HighlightUnicode
autocmd!
autocmd ColorScheme *
	\ syntax match nonascii "[^\x00-\x7F]" |
	\ highlight nonascii guibg=red ctermbg=2
augroup end
silent doautocmd HighlightUnicode ColorScheme

" Functions

" ---------------------------------------------------------------
" Persistent Undo
" ---------------------------------------------------------------
try
    let myundodir = expand($HOME . '/.undodir')
    call mkdir(myundodir, 'p')
    let &undodir = myundodir
    set undofile
catch
endtry

" ---------------------------------------------------------------
" Moving around
" ---------------------------------------------------------------

" When you press * or # search for the current selection
vnoremap <silent> * :<C-u>call <SID>VSetSearch()<cr>//<cr><C-o>
vnoremap <silent> # :<C-u>call <SID>VSetSearch()<cr>??<cr><C-o>

" Disable highlight when <leader><cr> is pressed
map <silent><leader><cr> :noh<cr>
" redraw the screen and remove any highlighting
nnoremap <silent><C-l> :nohl<cr><C-l>
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
     \   exe "normal! g`\""                           |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
" Only xterm can grab the mouse events when using the shift key, for other
" terminals use ":", select text and press Esc.
if has('mouse')
  if &term =~ 'xterm'
    set mouse=a
  else
    set mouse=nvi
  endif
endif

" ---------------------------------------------------------------
" Clipboard
" ---------------------------------------------------------------
aug Yank
	au!
	noremap <silent> y y:call WriteToVmuxClipboard()<cr>
	noremap <silent> x x:call WriteToVmuxClipboard()<cr>
	au FocusGained,BufEnter * silent! call ReadFromVmuxClipboard()
aug END

" This unsets the 'last search pattern' register by hitting return
nnoremap <silent><cr> :nohlsearch<cr><cr>

" ---------------------------------------------------------------
" Editing mappings
" ---------------------------------------------------------------
" Remap Vim 0 to first non-blank character
map 0 ^

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" [t]e -> [tab]edit
cnoreabbrev <expr> e getcmdtype() == ":" && getcmdline() == 'e' ? 'edit' : 'e'
cnoreabbrev <expr> te getcmdtype() == ":" && getcmdline() == 'te' ? 'tabedit' : 'te'

" ---------------------------------------------------------------
" Spell checking
" ---------------------------------------------------------------

map <silent><leader>ss :setlocal spell!<cr>                     | " Pressing ,ss will toggle and untoggle spell checking
nnoremap <silent><leader>Ss :setlocal spell spelllang=en_us<cr> | " Activate spelling
nnoremap <silent><leader>SS :setlocal nospell<cr>               | " Disable spelling
nnoremap <silent><leader>Sf z=                                  | " Fix word

" ---------------------------------------------------------------
" Misc
" ---------------------------------------------------------------
" Remove the Windows ^M - when the encodings gets messed up
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" convert Excel 4/2/20 to SQL '2020-4-2'
" s/\(\d*\)\/\(\d*\)\/\(\d*\)/'20\3-\1-\2'/g"

" Sudo save
cmap W! w !sudo tee % >/dev/null

" Don't use Q for Ex mode, use it for formatting. Except for Select mode.
map Q gq
sunmap Q

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" ---------------------------------------------------------------
" Filetype Specific
" ---------------------------------------------------------------
au BufRead,BufNewFile *.vb set filetype=vb
au BufRead,BufNewFile *.{bashrc,profile,sh,bash_profile} set filetype=bash
au BufRead,BufNewFile *.{js,mjs,cjs,jsm,es,es6},Jakefile set filetype=javascript
au BufRead,BufNewFile *.jinja set syntax=htmljinja
au BufRead,BufNewFile *.mako set filetype=mako
au BufRead,BufFilePre,BufNewFile README set filetype=markdown
au BufRead,BufNewFile *.scm set filetype=scheme
au BufRead /tmp/psql.edit.* set filetype=sql
au BufRead /tmp/ssql.edit.* set filetype=sql
au BufRead,BufNewFile Result set filetype=sql
au BufRead,BufFilePre,BufNewFile buffer set filetype=sql
au BufRead,BufNewFile *.ipynb set filetype=ipynb
au BufRead,BufNewFile *ideavimrc set filetype=vim
au FileType gitcommit call setpos('.', [0, 1, 1, 0])
au FocusGained * :redraw!

" Triger `autoread` when files changes on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
  \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Folding

" Cheatsheet

" zR: open all folds
" zM: close all folds
"
" czf#j creates a fold from the cursor down # lines.
" zf/string creates a fold from the cursor to string .
" zj moves the cursor to the next fold.
" zk moves the cursor to the previous fold.
" zo opens a fold at the cursor.
" zO opens all folds at the cursor.
" zm increases the foldlevel by one.
" zr decreases the foldlevel by one.
" zd deletes the fold at the cursor.
" zE deletes all folds.
" [z move to start of open fold.
" ]z move to end of open fold.

" Next

"
" Mappings

" Ctrl Mappings

" Cheatsheet
" <C-w>_ | " Max out the height of the current split
" <C-w>| | " Max out the width of the current split
" <C-w>= | " Normalize all split sizes, which is very handy when resizing terminal
" <C-w>+ | " Increase split size
" <C-w>- | " Decrease split size
" <C-w>j | " Move down
" <C-w>k | " Move up
" <C-w>h | " Move left
" <C-w>l | " Move right
" <C-w>R | " Swap top/bottom or left/right split
" <C-w>T | " Break out current window into a new tabview
" <C-w>o | " Close every window in the current tabview but the current one

nnoremap <C-h> <C-w>h                                       | " Switch window left
nnoremap <C-j> <C-w>j                                       | " Switch window down
nnoremap <C-k> <C-w>k                                       | " Switch window up
nnoremap <C-l> <C-w>l                                       | " Switch window right

" Buffer management
" [B     :bfirst
" ]B     :blast
nnoremap <silent><leader>bc :BufClose<cr>
nnoremap <silent><leader>bh :BufHiddenClose<cr>
nmap <silent><unique>]b <Plug>CycleToNextBuffer
nmap <silent><unique>[b <Plug>CycleToPreviousBuffer
au BufRead,BufNewFile * BufNoNameClose

" Navigation
if g:os == 'Linux'
  nnoremap <silent><C-p> :exe "FZF ".FindRootDirectory()<cr>
  nnoremap <silent><C-p><C-f> :Buffers<cr>
else
  nnoremap <silent><C-p> :CtrlP<cr>
endif

" Tag management
" [t     :tprevious
" ]t     :tnext
" [T     :tfirst
" ]T     :tlast

" Tab management
nnoremap <silent> <leader>gt :tabnext<cr>
nnoremap <silent> <leader>gT :tabprevious<cr>
nnoremap <silent> <leader>tn :tabnew<cr>
nnoremap <silent> <leader>to :tabonly<cr>
nnoremap <silent> <leader>tc :tabclose<cr>
nnoremap <silent> <leader>tm :tabmove
" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<cr>
au TabLeave * let g:lasttab = tabpagenr()
au BufFilePost * CloseDupTabs

" Terminal
" <C-w><C-w> to toggle splits
" <C-w>| or <c-w>_ to maximize
" <C-w>= for even spacing
" <C-w>: for normal mode
" <C-w>"" for pasting the " register
" <C-w>N to switch to normal mode
" <C-w> :dis[play] to see all available registers and their content
map <silent><leader>T :let $_=expand('%:p:h')<cr>:terminal ++close<cr>cd $_<cr>clear<cr>
tmap <silent><leader>T :let $_=expand('%:p:h')<cr><c-w>:terminal ++close<cr>cd $_<cr>clear<cr>

" Git
nnoremap <Leader>gb :Git blame<cr>
nnoremap <Leader>gs :Git status<cr>
nnoremap <leader>gL :call GitCommand("lg")<cr>
nnoremap <leader>gl :call GitCommand("log")<cr>
nnoremap <leader>gr :call GitCommand("reflog")<cr>
nnoremap <Leader>gh :Silent Glog<cr>
nnoremap <Leader>gH :Silent Glog<cr>:set nofoldenable<cr>
nnoremap <Leader>gd :Gdiffsplit<cr>
nnoremap <Leader>gc :Git commit<cr>
nnoremap <Leader>g- :Silent Git stash<CR>:e<CR>
nnoremap <Leader>g+ :Silent Git stash pop<CR>:e<CR>
" nnoremap <Leader>gr :Gread<CR>
" nnoremap <Leader>gw :Gwrite<CR>
" nnoremap <Leader>gp :Git push<CR>
nmap <Leader>ga <Plug>(GitGutterStageHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
nnoremap <silent><Leader>gp :call ToggleGitGutterPreviewHunk()<cr>
if ! &diff
  nmap ]g <Plug>(GitGutterNextHunk)
	nmap [g <Plug>(GitGutterPrevHunk)
endif

" " Window Swap
" let g:windowswap_map_keys = 0
" nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<cr>
" nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<cr>
" nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<cr>

" Format
nnoremap <silent><leader>ja :ALEFix<cr>
nnoremap <leader>jA :ALEToggle<cr>

" Grep
nnoremap <leader>jl :call GrepDoc()<cr>
nnoremap <silent><leader>jw :call GrepWs()<cr>

" LSP (rename with grep->quickfix->modify->write)
" <leader>jd: lsp-definition
" <leader>jr: lsp-references
" <leader>js: lsp-document-symbol-search
" <leader>jS: lsp-workspace-symbol-search
" <leader>ji: lsp-implementation
" <leader>jt: lsp-type-definition
" <leader>jh: lsp-hover
" <leader>rn: lsp-rename
"         [j: lsp-previous-diagnostic
"         ]j: lsp-next-diagnostic
" <expr><c-f> lsp#scroll:+4
" <expr><c-d> lsp#scroll:-4

" Substitute
nnoremap <leader>jj :%s/<c-r>=expand("<cword>")<cr>/

" Quickfix
" [q     :cprevious
" ]q     :cnext
" [Q     :cfirst
" ]Q     :clast
nnoremap <leader>co :botright copen<cr>
nnoremap <leader>cx :cclose<cr>
nmap <silent>\ <Plug>(qf_qf_toggle)
