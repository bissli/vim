"**************************************************************
" .vimrc
"**************************************************************
" OVERVIEW:
" A buffer is the in-memory text of a file
" A window is a viewport on a buffer
" A tab page is a collection of windows
"
" REFERENCES:
" - https://stackoverflow.com/a/26710166
" - Abbreviations: https://stackoverflow.com/a/9312070
"**************************************************************

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
set updatetime=250                                                       | " Help vim-gitgutter update quicker
set previewheight=15
set noswapfile                                                           | " No swap file
set nobackup                                                             | " No backup
set nowb                                                                 | " No write-backup
set nowrap                                                               | " Do not wrap by default
set shortmess+=c                                                         | " Suppress completion menu messages
set laststatus=2                                                         | " Alawys show statusline
set wildcharm=<tab>
set wildmode=list:longest
set wildignore=*.o,*~,*.pyc,*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite | " Wildignore
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
set timeoutlen=300                                                       | " Set a shorter timeout to reduce delay when typing j/k in insert mode
set ttimeoutlen=500                                                      | " Allows leader + multiple keystrokes
set title                                                                | " Put title on top of Vim
set splitbelow                                                           | " Default to splitting below, not above
set listchars+=space:␣                                                   | " Show trailing whitespace
set nofoldenable                                                         | " Disable folding
set display=truncate                                                     | " Show @@@ in the last line if it is truncated.
set autoindent
set scrolloff=5                                                          | " Show a few lines of context around the cursor.
set smarttab
set showbreak=->
set hlsearch
set ignorecase                                                           | " Ignore case by default when searching
set smartcase                                                            | " Switch to case sensitive mode if needle contains uppercase characters
set incsearch                                                            | " Do incremental searching when it's possible to timeout.
set number                                                               | " Always enable line numbers
set nrformats-=octal                                                     | " Do not recognize octal numbers for Ctrl-A and Ctrl-X
set lazyredraw                                                           | " lazy redraw by default

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
    if &term =~ '\v(tmux|xterm)-256color'
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
let myundodir = expand($HOME . '/.undodir')
call mkdir(myundodir, 'p')
let &undodir = myundodir
set undofile

" ---------------------------------------------------------------
" Moving around
" ---------------------------------------------------------------

" When you press * or # search for the current selection
vnoremap <silent> * :<C-u>call <SID>VSetSearch()<cr>//<cr><C-o>
vnoremap <silent> # :<C-u>call <SID>VSetSearch()<cr>??<cr><C-o>

" Specify the behavior when switching between buffers
set switchbuf=useopen,usetab,newtab
set showtabline=2

" Return to last edit position when opening files
augroup LastPosition
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\""                           |
       \ endif
augroup END

" Remember info about open buffers on close
set viminfo^=%

" ---------------------------------------------------------------
" Clipboard
" ---------------------------------------------------------------
augroup Yank
  autocmd!
  noremap <silent> y y:call WriteToVmuxClipboard()<cr>
  noremap <silent> x x:call WriteToVmuxClipboard()<cr>
  autocmd FocusGained,BufEnter * silent! call ReadFromVmuxClipboard()
augroup END

" This unsets the 'last search pattern' register by hitting return
nnoremap <silent><cr> :nohlsearch<cr><cr>

" ---------------------------------------------------------------
" Editing mappings
" ---------------------------------------------------------------
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
" Filetype Specific
" ---------------------------------------------------------------
augroup FileTypeDetection
  autocmd!
  autocmd BufRead,BufNewFile *.vb set filetype=vb
  autocmd BufRead,BufNewFile *.{bashrc,profile,sh,bash_profile} set filetype=bash
  autocmd BufRead,BufNewFile *.{js,mjs,cjs,jsm,es,es6},Jakefile set filetype=javascript
  autocmd BufRead,BufNewFile *.jinja set syntax=htmljinja
  autocmd BufRead,BufNewFile *.mako set filetype=mako
  autocmd BufRead,BufFilePre,BufNewFile README set filetype=markdown
  autocmd BufRead,BufNewFile *.scm set filetype=scheme
  autocmd BufRead /tmp/psql.edit.* set filetype=sql
  autocmd BufRead /tmp/ssql.edit.* set filetype=sql
  autocmd BufRead,BufNewFile Result set filetype=sql
  autocmd BufRead,BufFilePre,BufNewFile buffer set filetype=sql
  autocmd BufRead,BufFilePre,BufNewFile INSTRUCT set filetype=aider
  autocmd BufRead,BufNewFile *.ipynb set filetype=ipynb
  autocmd BufRead,BufNewFile *ideavimrc set filetype=vim
  autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
  autocmd FocusGained * :redraw!
augroup END

" Trigger `autoread` when files changes on disk
augroup AutoReloadFile
  autocmd!
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
    \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
augroup END

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

" Buffer management
" [B     :bfirst
" ]B     :blast
nnoremap <silent><leader>bc :BufClose<cr>
nnoremap <silent><leader>bh :BufHiddenClose<cr>
nmap <silent><unique>]b <Plug>CycleToNextBuffer
nmap <silent><unique>[b <Plug>CycleToPreviousBuffer
augroup BufferManagement
  autocmd!
  autocmd BufRead,BufNewFile * BufNoNameClose
augroup END

" Navigation
nnoremap <silent><C-p> :exe "FZF ".FindRootDirectory()<cr>
nnoremap <silent><C-p><C-f> :Buffers<cr>

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
augroup TabManagement
  autocmd!
  autocmd TabLeave * let g:lasttab = tabpagenr()
  autocmd BufFilePost * CloseDupTabs
augroup END

" Git
nnoremap <Leader>gb :Git blame<cr>
nnoremap <Leader>gs :Git status<cr>
nnoremap <Leader>gl :TigOpenCurrentFile<CR>
nnoremap <leader>gL :TigOpenProjectRootDir<cr>
nnoremap <Leader>gd :Gdiffsplit<cr>
nmap <Leader>ga <Plug>(GitGutterStageHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
nnoremap <silent><Leader>gp :call ToggleGitGutterPreviewHunk()<cr>
if ! &diff
  nmap ]g <Plug>(GitGutterNextHunk)
	nmap [g <Plug>(GitGutterPrevHunk)
endif

" Window Swap
" <leader>ww -> yank
" <leader>ww -> paste

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
