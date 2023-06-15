if !isdirectory(expand($HOME . "/.vim/autoload"))
  if has('win32') || has('win64')
    silent ! iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
      ni $HOME/vimfiles/autoload/plug.vim -Force
  else
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif
  autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
    \| endif
endif

call plug#begin(expand($HOME.'/.vim/plugged'))

" layout
Plug 'bissli/inkpot'
Plug 'vim-scripts/colorsupport.vim'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'bissli/vim-close-duplicate-tabs'
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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } | Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
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
Plug 'cohama/lexima.vim', { 'for': ['javascript', 'python'] }
Plug 'alvan/vim-closetag', { 'for': ['html', 'xhtml', 'phtml'] }
Plug 'valloric/MatchTagAlways', { 'for': ['html', 'xhtml', 'phtml'] }
" slime/jupyter
Plug 'goerz/jupytext.vim'
Plug 'jpalardy/vim-slime', {'for': ['r', 'python'] }
Plug 'klafyvel/vim-slime-cells', {'for': ['r', 'python'] }
" language tools / syntax
Plug 'editorconfig/editorconfig-vim'
Plug 'masukomi/vim-markdown-folding', { 'for': ['markdown'] }
Plug 'jalvesaq/R-Vim-runtime', { 'for': ['r'] }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': ['python'] }
Plug 'pangloss/vim-javascript', { 'for': ['javscript'] }
" markdown
Plug 'preservim/vim-markdown'
" buffers
Plug 'Asheq/close-buffers.vim'
" AI
" Plug 'bissli/vim-chatgpt', {'for': ['python']}
Plug 'github/copilot.vim', {'for': ['python']}
Plug 'rhysd/vim-healthcheck'

call plug#end()

func! g:PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ isdirectory(g:plugs[a:name].dir) &&
        \ stridx(&rtp, substitute(g:plugs[a:name].dir, "\/$", "", "")) >= 0
	\ )
endfunc
