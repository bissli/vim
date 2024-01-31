filetype plugin indent on

runtime plugin/platform.vim
call platform#detect()

call plug#begin(expand($HOME.'/.vim/plugged'))

" general
Plug 'bissli/inkpot'
if g:os == 'Linux'
  Plug 'vim-scripts/colorsupport.vim'
endif
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'sorribas/vim-close-duplicate-tabs'
Plug 'preservim/tagbar'
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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } } | Plug 'junegunn/fzf.vim'
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
Plug 'iberianpig/tig-explorer.vim', !has('win32') ? {} : { 'on': [] }
Plug 'rhysd/conflict-marker.vim'
Plug 'airblade/vim-gitgutter'
" db
Plug 'collinpeters/dbext.vim', { 'for': ['sql', 'buffer'] }
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
Plug 'inkarkat/vim-ExtractMatches'
Plug 'inkarkat/vim-ingo-library'
Plug 'pixelneo/vim-python-docstring', { 'for': ['python'] }
" markdown
Plug 'preservim/vim-markdown'
" Testing
Plug 'vim-test/vim-test'
" AI
" Plug 'bissli/vim-chatgpt', {'for': ['python']}
Plug 'github/copilot.vim'
Plug 'rhysd/vim-healthcheck'
" Slime
Plug 'jpalardy/vim-slime', { 'for': ['python', 'r', 'markdown'] }
Plug 'hanschen/vim-ipython-cell', { 'for': ['python', 'r', 'markdown'] }

call plug#end()

func! PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ isdirectory(g:plugs[a:name].dir) &&
        \ stridx(&rtp, substitute(g:plugs[a:name].dir, "\/$", "", "")) >= 0
	\ )
endfunc
