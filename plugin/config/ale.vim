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
  let g:ale_open_list = 1
  let g:ale_set_signs = 0
  let g:ale_set_highlights = 0
  let g:ale_sign_error = "~"
  let g:ale_sign_warning = "~"
  let g:ale_sign_style_error = '~'
  let g:ale_sign_style_warning = '~'
  let g:ale_use_global_executables = 1

  " auto env (cd managed by smartcd)
  let g:ale_python_auto_pipenv = 0
  let g:ale_python_auto_poetry = 0
  let g:ale_python_auto_virtualenv = 0
  let g:ale_python_flake8_auto_poetry = 0
  let g:ale_python_flake8_auto_pipenv = 0
  let g:python_pylint_auto_pipenv = 0
  let g:python_pylint_auto_poetry = 0

  " => lint
  let g:ale_linters = {
	  \'javascript': ['eslint'],
	  \'python': ['flake8', 'pylint'],
	  \'go': ['go', 'golint', 'errcheck'],
	  \'cpp': ['clangtidy'],
	  \'cs': ['OmniSharp'],
	  \'c': ['clangtidy'],
	  \'tex': ['chktex'],
	  \'matlab': ['mlint'],
  \}
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_lint_on_enter = 0
  let g:ale_lint_on_save = 0
  let g:ale_lint_on_text_changed = 0
  let g:ale_lint_on_insert_leave = 0
  let g:ale_lint_on_filetype_changed = 0
  " clang-tidy
  let g:ale_cpp_clangtidy_checks = []
  let g:ale_cpp_clangtidy_executable = 'clang-tidy'
  let g:ale_c_parse_compile_commands=1
  let g:ale_cpp_clangtidy_extra_options = ''
  let g:ale_cpp_clangtidy_options = ''
  " flake8
  " " Don't warn on
  "   E121 continuation line indentation is not a multiple of four
  "   E124 closing bracket does not match visual indentation
  "   E126 continuation line over-indented for hanging indent
  "   E128 continuation line under-indented for visual indent
  "   E201 whitespace after [
  "   E203 space before :
  "   E221 multiple spaces before operator
  "   E222 multiple spaces after operator
  "   E231 missing whitespace asfter ':'
  "   E241 multiple spaces after ':'
  "   E251 unexpected spaces around keyword / parameter equals
  "   E272 multiple spaces before keyword
  "   E301 expected 1 blank line, found 0
  "   E402 do not assign a lamda expression, use a def
  "   E501 line too long
  "   E722 do not use bare 'except'
  "   E731 do not assign a lambda expression, use a def 
  "   E1101 no-member: Instance of 'foo' has no 'bar' member 
  "   W503 line break occurred before a binary operator
  "   W504 module level importnot at top of file
  "   S001, B005, B006, B007, B008, B009, B010, B011, B015, B301 (for mypy compatability)
  let s:errors = 'E121,E124,E126,E128,E201,E203,E221,E222,E231,E241,E251,E272,E301,E402,E501,E722,E731,E1101'
  let s:warnings = 'W501,W503,W504' 
  let s:other = 'S001,B005,B006,B007,B008,B009,B010,B011,B015,B301'
  let g:pep8_ignore = s:errors . ',' . s:warnings . ',' . s:other 
  let g:ale_python_flake8_options='--ignore='.pep8_ignore.' --max-line-length=119'
  let g:ale_python_pylint_options='--disable=all --enable=F,E,unused-variable,unused-import,unreachable,duplicate_key,wrong-import-order,unecessary-pass'
  let g:ale_python_autoflake_options = "--remove-all-unused-imports --expand-star-imports --ignore-init-module-imports"

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
	  \'python'     : ['autoflake', 'isort', 'docformatter', 'black'],
	  \'go'         : ['golint'],
	  \'xml'        : ['xmllint'],
	  \'toml'       : ['dprint'],
	  \'md'         : ['dprint'],
	  \'xsd'        : ['xmllint'],
	  \'matlab'     : ['mlint'],
	  \'sql'        : ['sqlformat']
  \}
  let g:ale_fixers_explicit = 1
  let g:ale_fix_on_save_ignore = 1
  let g:ale_fix_on_enter = 0
  let g:ale_javascript_prettier_use_local_config = 0
  let g:ale_sql_pgformatter_options = "--spaces 4 --comma-break --function-case 1 --keyword-case 1 --type-case 1"
  let g:ale_python_pydocstyle_options = '--max-line-length=119 --convention=numpy --add-ignore=D100,D101,D102,D103,D104,D105,D106,D107,D202'
  let g:ale_python_black_options = '--line-length 119 --skip-string-normalization'
  let g:ale_cpp_clangformat_options = '--style="{IndentWidth: 4, ColumnLimit: 119}"'
  let g:ale_c_clangformat_options = '--style="{IndentWidth: 4, ColumnLimit: 119}"'
  let g:ale_html_beautify_options = '--indent-size 2'

  func! g:SqlformatFormatRange() range
	  exe ":'<,'> !sqlformat " . g:ale_sql_sqlformat_options
  endfunc

  au Filetype sql exec 'xnoremap <silent><buffer><leader>ff <Esc>:call SqlformatFormatRange()<cr>'

endif
