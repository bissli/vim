filetype plugin indent on

call plug#begin(expand($HOME.'/.vim/plugged'))

" general 
Plug 'bissli/inkpot'
Plug 'vim-scripts/colorsupport.vim'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'bissli/vim-close-duplicate-tabs'
Plug 'liuchengxu/vista.vim'
" Plug 'gerw/vim-HiLinkTrace'
" quickfix
Plug 'romainl/vim-qf'
Plug 'romainl/vim-qlist'
Plug 'stefandtw/quickfix-reflector.vim'
" mappings
Plug 'tpope/vim-unimpaired'
" text
Plug 'godlygeek/tabular'
Plug 'preservim/nerdcommenter'
" tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'bissli/vmux-clipboard'
" searching
Plug 'airblade/vim-rooter'
Plug 'ludovicchabant/vim-gutentags'
if g:os == 'Linux'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
else
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'bissli/ctrlp_bdelete.vim'
  Plug 'bissli/ctrlp-py-matcher'
endif
" completion / lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'yami-beta/asyncomplete-omni.vim'
" linting
Plug 'dense-analysis/ale'
Plug 'rhysd/vim-lsp-ale'
" snippets
Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets'
" git
Plug 'tpope/vim-fugitive', !has('win32') ? {} : { 'on': [] }
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/conflict-marker.vim'
" db
Plug 'bissli/dbext.vim', { 'for': ['sql', 'buffer'] }
" parenthesis/brackets
Plug 'tpope/vim-endwise'
Plug 'cohama/lexima.vim'
Plug 'alvan/vim-closetag', { 'for': ['html'] }
Plug 'valloric/MatchTagAlways', { 'for': ['html'] }
" language tools / syntax
Plug 'inkarkat/vim-SyntaxRange'
Plug 'editorconfig/editorconfig-vim'
Plug 'masukomi/vim-markdown-folding', { 'for': ['markdown'] }
Plug 'jalvesaq/R-Vim-runtime', { 'for': ['r'] }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': ['python'] }
Plug 'pangloss/vim-javascript', { 'for': ['javscript'] }
" markdown
Plug 'preservim/vim-markdown'
" AI
" Plug 'bissli/vim-chatgpt', {'for': ['python']}
Plug 'github/copilot.vim'
Plug 'rhysd/vim-healthcheck'
" Slime
Plug 'jpalardy/vim-slime', { 'for': ['python', 'r', 'markdown'] }
Plug 'hanschen/vim-ipython-cell', { 'for': ['python', 'r', 'markdown'] }

call plug#end()

func! g:PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ isdirectory(g:plugs[a:name].dir) &&
        \ stridx(&rtp, substitute(g:plugs[a:name].dir, "\/$", "", "")) >= 0
	\ )
endfunc
