if PlugLoaded('ale')

  let g:ale_pattern_options = {
  \   '.*\.md$'       : {'ale_enabled': 0},
  \   '.*\.markdown$' : {'ale_enabled': 0},
  \   '.*\.rst$'      : {'ale_enabled': 0},
  \   '.*\.txt$'      : {'ale_enabled': 0},
  \   '.*\.tex$'      : {'ale_enabled': 0},
  \   '\.min\.js$'    : {'ale_enabled': 0},
  \   '\.min\.css$'   : {'ale_enabled': 0},
  \}
  let g:ale_enabled = 0
  let g:ale_open_list = 0
  let g:ale_set_signs = 1
  let g:ale_set_highlights = 0
  let g:ale_sign_error = "~"
  let g:ale_sign_warning = "~"
  let g:ale_sign_style_error = '~'
  let g:ale_sign_style_warning = '~'
  let g:ale_use_global_executables = 1

  " => lint
  let g:ale_linters = {
	  \'javascript': ['eslint'],
	  \'python': ['vim-lsp'],
	  \'go': ['go', 'golint', 'errcheck'],
	  \'cpp': ['clangtidy'],
	  \'cs': ['OmniSharp'],
	  \'c': ['clangtidy'],
	  \'tex': ['chktex'],
	  \'matlab': ['mlint'],
  \}
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_lint_on_enter = 1
  let g:ale_lint_on_save = 1
  let g:ale_lint_on_text_changed = 0
  let g:ale_lint_on_insert_leave = 0
  let g:ale_lint_on_filetype_changed = 0
  " clang-tidy
  let g:ale_cpp_clangtidy_checks = []
  let g:ale_cpp_clangtidy_executable = 'clang-tidy'
  let g:ale_c_parse_compile_commands=1
  let g:ale_cpp_clangtidy_extra_options = ''
  let g:ale_cpp_clangtidy_options = ''

  " => fix / format

  function PythonDocFormatter(buffer) abort
      return {
      \   'command': 'docformatter --black -'
      \}
  endfunction

  let g:ale_sql_sqlformat_options = join(['',
	  \'--reindent',
	  \'--indent_width 4',
	  \'--indent_columns',
	  \'--keywords lower',
	  \'--identifiers lower -'], ' ')
  function SqlFormatFormatter(buffer) abort
      return {
      \   'command': 'sqlformat ' . g:ale_sql_sqlformat_options
      \}
  endfunction

  execute ale#fix#registry#Add('docformatter', 'PythonDocFormatter', ['python'], 'docformatter for python')
  execute ale#fix#registry#Add('sqlformat', 'SqlFormatFormatter', ['sql'], 'sqlformat formatter for sql')

  let g:ale_fixers = {
	  \'*'          : ['remove_trailing_lines', 'trim_whitespace'],
	  \'html'       : ['html-beautify'],
	  \'javascript' : ['eslint'],
	  \'json'       : ['fixjson'],
	  \'css'        : ['stylelint', 'prettier'],
	  \'c'          : ['clang-format'],
	  \'cpp'        : ['clang-format'],
	  \'python'     : ['ruff'],
	  \'go'         : ['golint'],
	  \'xml'        : ['xmllint'],
	  \'toml'       : ['dprint'],
	  \'md'         : ['dprint'],
	  \'xsd'        : ['xmllint'],
	  \'matlab'     : ['mlint'],
	  \'sql'        : ['sqlformat'],
	  \'r'          : ['styler']
  \}
  let g:ale_fixers_explicit = 1
  let g:ale_fix_on_save_ignore = 1
  let g:ale_fix_on_enter = 0
  let g:ale_javascript_prettier_use_local_config = 0
  let g:ale_sql_pgformatter_options = "--spaces 4 --comma-break --function-case 1 --keyword-case 1 --type-case 1"
  let g:ale_python_black_options = '--line-length 88 --skip-string-normalization'
  let g:ale_cpp_clangformat_options = '--style="{IndentWidth: 4, ColumnLimit: 119}"'
  let g:ale_c_clangformat_options = '--style="{IndentWidth: 4, ColumnLimit: 119}"'
  let g:ale_html_beautify_options = '--indent-size 2'

  func! g:SqlformatFormatRange() range
	  exe ":'<,'> !sqlformat " . g:ale_sql_sqlformat_options
  endfunc
  au Filetype sql exec 'xnoremap <silent><buffer><leader>ja <Esc>:call SqlformatFormatRange()<cr>'

  func! g:BlackformatFormatRange() range
	  exe ":'<,'> !black-macchiato " . g:ale_python_black_options
  endfunc
  au Filetype python exec 'xnoremap <silent><buffer><leader>jb <Esc>:call BlackformatFormatRange()<cr>'

endif
