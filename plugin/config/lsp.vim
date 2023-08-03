if PlugLoaded('vim-lsp')

  if !has('nvim')
    set completeopt+=menu,popup,menuone,noselect,noinsert,longest
  endif

  " vim-lsp options
  let g:lsp_diagnostics_enabled = 1
  let g:lsp_document_highlight_enabled = 0
  let g:lsp_format_sync_timeout = 1000
  let g:lsp_document_code_action_signs_enabled = 0
  let g:lsp_preview_float = 1
  let g:lsp_signature_help_enabled = 1
  let g:lsp_semantic_enabled = 1
  let g:lsp_log_verbose = 0
  let g:lsp_log_file = expand($HOME.'/.vim/vim-lsp.log')
  " vim-lsp-ale options
  let g:lsp_ale_auto_config_vim_lsp = 1
  let g:lsp_ale_auto_enable_linters = 0
  " vim-lsp-settings options
  let g:lsp_settings_servers_dir = expand($HOME.'/.vim/servers/')
  let g:lsp_settings_global_settings_dir = expand($HOME.'/.config/vim-lsp/')
  let g:lsp_settings_root_markers = ['.fzf', '.root']
  let g:lsp_settings_enable_suggestions = 0
  " asyncomplete options
  let g:asyncomplete_auto_popup = 1
  let g:asyncomplete_auto_completeopt = 1
  let g:asyncomplete_min_chars = 2
  let g:asyncomplete_remove_duplicates = 0
  let g:asyncomplete_smart_completion = 0
  let g:asyncomplete_buffer_clear_cache = 1
  let g:markdown_fenced_languages = ["text=markdown"]
  let g:asyncomplete_log_file = expand('~/.vim/vim-asyncomplete.log')
  " ultisnips options
  let g:UltiSnipsSnippetsDir=expand("~/.vim/ultisnips")
  let g:UltiSnipsSnippetDirectories=["ultisnips"]
  let g:UltiSnipsExpandTrigger="<nop>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  let g:ultisnips_python_quoting_style="single"

  au Filetype snippets setlocal noexpandtab " requires explicit tab

  func! TryUltiSnips()
    let g:ulti_expand_or_jump_res = 0
    if !pumvisible()
        call UltiSnips#ExpandSnippetOrJump()
    endif
    return ""
  endfunc

  func! TryAsyncomplete()
    if g:ulti_expand_or_jump_res
      return ""
    elseif pumvisible()
      return "\<C-n>"
    elseif strpart( getline('.'), 0, col('.')-1 ) !~ '^\s*$'
      return "\<C-r>=asyncomplete#force_refresh()\<cr>"
    else
      return "\<Tab>"
    endif
  endfunc

  inoremap <silent><expr> <plug>(TryAsync) TryAsyncomplete()
  imap <plug>(TryUlti) <C-r>=TryUltiSnips()<cr>
  imap <silent><expr><Tab> "\<plug>(TryUlti)\<plug>(TryAsync)"
  " for jumping when a snippet has a placeholder value
  snoremap <silent><Tab><Esc> :call UltiSnips#ExpandSnippetOrJump()<cr>

  au InsertEnter * exec 'imap <silent><expr><buffer><Tab> "\<plug>(TryUlti)\<plug>(TryAsync)"'
  au InsertEnter * exec 'imap <silent><expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"'

  " run LSP server
  func! s:OnLspBufferEnabled() abort
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> <leader>jd <plug>(lsp-definition)
    nmap <buffer> <leader>jr <plug>(lsp-references)
    nmap <buffer> <leader>js <plug>(lsp-document-symbol-search)
    nmap <buffer> <leader>jS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> <leader>ji <plug>(lsp-implementation)
    nmap <buffer> <leader>jt <plug>(lsp-type-definition)
    nmap <buffer> <leader>jh <plug>(lsp-hover)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer>[j <Plug>(lsp-previous-diagnostic)
    nmap <buffer>]j <Plug>(lsp-next-diagnostic)
    nnoremap <buffer> <expr><C-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><C-d> lsp#scroll(-4)
  endfunc

  augroup lsp_install
      au!
      autocmd User lsp_buffer_enabled call s:OnLspBufferEnabled()
  augroup END

  func! CopilotVisible()
    let copilot_result = g:copilot#GetDisplayedSuggestion()
    return has_key(copilot_result, 'text') && copilot_result['text'] != ''
  endfunc

  " move up and down in autocomplete with <c-j> and <c-k>
  inoremap <expr> <C-j> CopilotVisible() ? "\<Plug>(copilot-next)": ("\<C-n>")
  inoremap <expr> <C-k> CopilotVisible() ? "\<Plug>(copilot-previous)": ("\<C-p>")
  " close popup
  inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"
  inoremap <expr> <C-y> pumvisible() ? asyncomplete#close_popup() : "\<C-y>"
  inoremap <expr> <C-e> pumvisible() ? asyncomplete#cancel_popup() : "\<C-e>"
  " close pum when finished
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

  func! s:sort_and_dedupe_asyncomplete_preprocessor(options, matches) abort
      let dict = {}
      for [source_name, matches] in items(a:matches)
          let source_priority = get(asyncomplete#get_source_info(source_name), 'priority', 0)
          for item in matches['items']
              if stridx(item['word'], a:options['base']) == 0
                  let item['priority'] = source_priority
                  " sort info
                  let user_data = lsp#omni#get_managed_user_data_from_completed_item(item)
                  let completion_item = get(user_data, 'completion_item', {})
                  let item['sort'] = get(completion_item, 'sortText', get(completion_item, 'label', ''))
                  " add if does not exist and/or update if higher priority
                  if has_key(dict,item['word'])
                      let old_item = get(dict, item['word'])
                      if old_item['priority'] <  source_priority
                          let dict[item['word']] = item
                      endif
                  else
                      let dict[item['word']] = item
                  endif
              endif
          endfor
      endfor
      " sort by alphabetical order, then place higher priority items on top
      let items = sort(values(dict), {a, b -> a['sort'] == b['sort'] ? 0 : a['sort'] > b['sort'] ? 1 : -1})
      let items = sort(items,{a, b -> b['priority'] - a['priority']})
      call asyncomplete#preprocess_complete(a:options, items)
  endfunc
  let g:asyncomplete_preprocessor = [function('s:sort_and_dedupe_asyncomplete_preprocessor')]

  " autocomplete completors priority highest = first)
  au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
      \ 'name': 'omni',
      \ 'allowlist': ['*'],
      \ 'blocklist': ['c', 'cpp', 'html'],
      \ 'priority': 20,
      \ 'completor': function('asyncomplete#sources#omni#completor'),
      \ 'config': {
      \   'show_source_kind': 1,
      \ },
      \ }))
  au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
      \ 'name': 'file',
      \ 'allowlist': ['*'],
      \ 'priority': 10,
      \ 'completor': function('asyncomplete#sources#file#completor')
      \ }))

  let directories=glob(fnameescape(g:lsp_settings_servers_dir).'/{,.}*/', 1, 1)
  call map(directories, 'fnamemodify(v:val, ":h:t")')

  let g:lsp_settings_filetype_python = [
      \ 'jedi-language-server',
      \ 'pylsp',
      \ 'ruff-lsp'
      \]

  if index(directories, 'jedi-language-server') != -1
    call remove(g:lsp_settings_filetype_python, 'jedi-language-server')
    call add(g:lsp_settings_filetype_python, 'jedi-language-server~')
  endif

  if index(directories, 'pylsp') != -1
    call remove(g:lsp_settings_filetype_python, 'pylsp')
    call add(g:lsp_settings_filetype_python, 'pylsp~')
  endif

  if index(directories, 'ruff-lsp') != -1
    call remove(g:lsp_settings_filetype_python, 'ruff-lsp')
    call remove(g:lsp_settings_filetype_python, 'ruff-lsp')
    call add(g:lsp_settings_filetype_python, 'ruff-lsp~')
  endif

  let g:jedi_language_server_path = g:lsp_settings_servers_dir . 'jedi-language-server/jedi-language-server'
  let g:pylsp_language_server_path = g:lsp_settings_servers_dir . 'pylsp/pylsp'
  let g:ruff_language_server_path = g:lsp_settings_servers_dir . 'ruff-lsp/ruff-lsp'

  if executable(g:pylsp_language_server_path)
      au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp~',
        \ 'cmd': {server_info->[g:pylsp_language_server_path]},
        \ 'allowlist': ['python'],
        \ 'workspace_config':
        \ {'pylsp':
        \	{'plugins': {
        \		'jedi_completion': {'enabled': v:true},
        \		'jedi_hover': {'enabled': v:true},
        \		'jedi_references': {'enabled': v:true},
        \		'jedi_signature_help': {'enabled': v:true},
        \		'jedi_symbols': {'enabled': v:true},
        \		'jedi_definintion': {'enabled': v:true},
        \		'rope_completion': {'enabled': v:true},
        \		'pycodestyle': {'enabled': v:false},
        \		'flake8': {'enabled': v:false},
        \		'mypy': {'enabled': v:false},
        \		'isort': {'enabled': v:false},
        \		'yapf': {'enabled': v:false},
        \		'pylint': {'enabled': v:false},
        \		'pydocstyle': {'enabled': v:false},
        \		'mccabe': {'enabled': v:false},
        \		'preload': {'enabled': v:false},
        \	},
        \}},
        \ })
  endif
  if executable(g:jedi_language_server_path)
      au User lsp_setup call lsp#register_server({
        \ 'name': 'jedi-language-server~',
        \ 'cmd': {server_info->[g:jedi_language_server_path]},
        \ 'allowlist': ['python'],
        \ 'initialization_options': {
        \	'diagnostics': {
        \		'enable': v:false,
        \		'didOpen': v:false,
        \		'didChange': v:false,
        \		'didSave': v:false,
        \	},
        \ },
        \ })
  endif
  if executable(g:ruff_language_server_path)
      au User lsp_setup call lsp#register_server({
        \ 'name': 'ruff-lsp~',
        \ 'cmd': {server_info->[g:ruff_language_server_path]},
        \ 'allowlist': ['python']
        \ })
  endif

  func! PreviewHeightWorkAround()
    if &previewwindow
      exec 'setlocal winheight='.&previewheight
    endif
  endfunc

  au BufEnter ?* call PreviewHeightWorkAround()

endif
