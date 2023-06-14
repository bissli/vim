" :Less
" turn vim into a pager for psql aligned results 
" https://unix.stackexchange.com/a/27840
fun! Less()
  
    set noswapfile
    set nocompatible
    set nowrap
    set noshowmode
    set scrollopt=hor
    set scrollbind

    " Delete/copy header lines
    silent execute '1,2d'
    " Split screen with new buffer (opens at top)
    execute 'new'
    " Switch to upper split
    wincmd k
    " Paste the header over the blank line
    execute 'norm! Vp'
    " Keep only header line
    silent execute '2d'
    " Switch back to lower split for scrolling
    wincmd j
    " Remove tail fluff 
    silent execute '$-1,$d'
    " Set lower split height to maximum
    execute "norm! \<c-W>_"
    " Go to top
    execute "norm! gg"
    " Hide statusline in lower window
    set laststatus=0
    " Set status line of upper window 
    set statusline=        
    set fillchars=stl:-
    set fillchars+=stlnc:-
    
    " Arrows do scrolling instead of moving
    nmap <silent> <Up> 3-
    nmap <silent> <Down> 3+
    nmap <silent> <Left> zH
    nmap <silent> <Right> zL
    nmap <Space> <PageDown>
    " Faster quit 
    nmap <silent> q :qa!<c-M>
    nmap <silent> Q :qa!<c-M>

    " Ignore external updates to the buffer
    autocmd! FileChangedShell */fd/*
    autocmd! FileChangedRO */fd/* 
    
    " Jump back to source window
    set clipboard^=unnamed,unnamedplus
    source ~/.vim/plugged/vim-tmux-navigator/plugin/tmux_navigator.vim
    
    " Colors
    syntax enable
    set filetype=sql
    if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
        set t_Co=256
    endif
    set background=dark
    try
	    colorscheme inkpot
    catch
    endtry

    hi NormalColor guifg=#cd8b00 guibg=bg 
    set statusline+=%#NormalColor#%{''}

endfun
command! -nargs=0 Less call Less()
