if PlugLoaded('coc.nvim')

  " navigate snippet placeholders using tab
  let g:coc_snippet_next = '<Tab>'
  let g:coc_snippet_prev = '<S-Tab>'

  " list of the extensions to make sure are always installed
  let g:coc_global_extensions = [
      \'coc-yank',
      \'coc-pairs',
      \'coc-json',
      \'coc-css',
      \'coc-html',
      \'coc-tsserver',
      \'coc-yaml',
      \'coc-lists',
      \'coc-snippets',
      \'coc-pyright',
      \'coc-clangd',
      \'coc-prettier',
      \'coc-xml',
      \'coc-syntax',
      \'coc-git',
      \'coc-marketplace',
      \'coc-highlight',
      \'coc-sh',
      \]

  " required by coc
  set hidden
  set nobackup
  set nowritebackup
  set cmdheight=1
  set updatetime=300
  set shortmess+=c

  " background color = editor color
  set signcolumn=number

  " coc multi cursor highlight color
  hi CocCursorRange guibg=#b16286 guifg=#ebdbb2

  " highlight match on cursor hold
  au CursorHold * silent call CocActionAsync('highlight')

  " coc completion popup
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endifa

  " format with available file format formatter
  command! -nargs=0 Format :call CocAction('format')

  " check if last inserted char is a backspace (used by coc pmenu)
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " show docs on things with K
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " use tab to navigate snippet placeholders
  inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ?
      \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ check_back_space() ? "\<TAB>" :
      \ coc#refresh()

  let g:coc_snippet_next = '<tab>'

  " use enter to accept completion
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

  " multi cursor shortcuts
  nmap <silent> <C-a> <Plug>(coc-cursors-word)
  xmap <silent> <C-a> <Plug>(coc-cursors-range)

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " other stuff
  nmap <leader>rn <Plug>(coc-rename)
  nmap <leader>o :OR <CR>

  " jump stuff
  nmap <leader>jd <Plug>(coc-definition)
  nmap <leader>jt <Plug>(coc-type-definition)
  nmap <leader>ji <Plug>(coc-implementation)
  nmap <leader>jr <Plug>(coc-references)

  " other coc actions
  nnoremap <leader>jh :call <SID>show_documentation()<CR>
  nmap <leader>a <Plug>(coc-codeaction-line)
  xmap <leader>a <Plug>(coc-codeaction-selected)

endif
