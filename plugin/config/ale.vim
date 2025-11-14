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
	  \'vim'   : ['vimls']
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

  " see pypi.org/project/autopep8/
  " INCLUDE LIST:
  let _pep8_include_list = [
    \ 'E124', 'Align closing bracket to match visual indentation.',
    \ 'E127', 'Fix visual indentation.',
    \ 'E128', 'Fix visual indentation.',
    \ 'E129', 'Fix visual indentation.',
    \ 'E131', 'Fix hanging indent for unaligned continuation line.',
    \ 'E133', 'Fix missing indentation for closing bracket.',
    \ 'E242', 'Remove extraneous whitespace around operator.',
    \ 'E251', 'Remove whitespace around parameter = sign.',
    \ 'E26',  'Fix spacing after comment hash for inline comments.',
    \ 'E265', 'Fix spacing after comment hash for block comments.',
    \ 'E266', 'Fix too many leading tripple quote for block comments.',
    \ 'E302', 'Add missing 2 blank lines.',
    \ 'E303', 'Remove extra blank lines.',
    \ 'E304', 'Remove blank line following function decorator.',
    \ 'E305', 'Expected 2 blank lines after end of function or class.',
    \ 'E502', 'Remove extraneous escape of newline.',
    \ 'E711', 'Fix comparison with None.',
    \ 'E712', 'Fix comparison with boolean.',
    \ 'E713', 'Use not in for test for membership.',
    \ 'E714', 'Use is not test for object identity.',
    \ 'E721', 'Use isinstance() instead of comparing types directly.',
    \ 'W291', 'Remove trailing whitespace.',
    \ 'W292', 'Add a single newline at the end of the file.',
    \ 'W293', 'Remove trailing whitespace on blank line.',
    \ 'W391', 'Remove trailing blank lines.',
    \ 'W690', 'Fix various deprecated code (via lib2to3).',
    \ ]
  " IGNORE LIST:
  let _pep8_ignore_list = [
    \ 'E101', 'Reindent all lines.',
    \ 'E121', 'Fix indentation to be a multiple of four.',
    \ 'E122', 'Add absent indentation for hanging indentation.',
    \ 'E123', 'Align closing bracket to match opening bracket.',
    \ 'E125', 'Indent to distinguish line from next logical line.',
    \ 'E126', 'Fix over-indented hanging indentation.',
    \ 'E20',  'Remove extraneous whitespace.',
    \ 'E201', 'Whitepace after [.',
    \ 'E203', 'Space before :.',
    \ 'E211', 'Remove extraneous whitespace.',
    \ 'E301', 'Add missing blank line.',
    \ 'E22',  'Fix extraneous whitespace around keywords.',
    \ 'E221', 'Multiple spaces before operator.',
    \ 'E222', 'Multiple spaces after operator.',
    \ 'E224', 'Remove extraneous whitespace around operator.',
    \ 'E225', 'Fix missing whitespace around operator.',
    \ 'E226', 'Fix missing whitespace around arithmetic operator.',
    \ 'E227', 'Fix missing whitespace around bitwise/shift operator.',
    \ 'E228', 'Fix missing whitespace around modulo operator.',
    \ 'E231', 'Add missing whitespace.',
    \ 'E241', 'Fix extraneous whitespace around keywords.',
    \ 'E252', 'Missing whitespace around parameter equals.',
    \ 'E27',  'Fix extraneous whitespace around keywords.',
    \ 'E272', 'Multiple spaces before keyword.',
    \ 'E306', 'Expected 1 blank line before a nested definition.',
    \ 'E401', 'Put imports on separate lines.',
    \ 'E402', 'Fix module level import not at top of file',
    \ 'E501', 'Try to make lines fit within --max-line-length characters.',
    \ 'E70',  'Put semicolon-separated compound statement on separate lines.',
    \ 'E701', 'Put colon-separated compound statement on separate lines.',
    \ 'E722', 'Fix bare except.',
    \ 'E731', 'Use a def when use do not assign a lambda expression.',
    \ 'W503', 'Fix line break before binary operator.',
    \ 'E11',  'Fix indentation.',
    \ 'W504', 'Fix line break after binary operator.',
    \ 'W605', 'Fix invalid escape sequence x.',
    \ ]
  let g:pep8_ignore_list = []
  for i in range(0, len(_pep8_ignore_list)-1)
    if i % 2 == 0 | call add(g:pep8_ignore_list, _pep8_ignore_list[i]) | endif
  endfor
  let g:pep8_ignore = join(g:pep8_ignore_list, ',')
  let g:ale_python_autopep8_options = '--ignore '.pep8_ignore.' --aggressive --max-line-length 79'

  function YapfFormatter(buffer) abort
      return {
      \   'command': 'yapf --style ~/.config/yapf/style'
      \}
  endfunction

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

  execute ale#fix#registry#Add('yapf_global', 'YapfFormatter', ['python'], 'yapf with global config')
  execute ale#fix#registry#Add('docformatter', 'PythonDocFormatter', ['python'], 'docformatter for python')
  execute ale#fix#registry#Add('sqlformat', 'SqlFormatFormatter', ['sql'], 'sqlformat formatter for sql')

  let g:ale_fixers = {
	  \'*'          : ['remove_trailing_lines', 'trim_whitespace'],
	  \'html'       : ['html-beautify'],
	  \'javascript' : ['eslint'],
	  \'css'        : ['stylelint', 'prettier'],
	  \'c'          : ['clang-format'],
	  \'cpp'        : ['clang-format'],
	  \'cs'         : ['dotnet-format'],
	  \'python'     : ['isort', 'ruff', 'autopep8'],
	  \'go'         : ['golint'],
	  \'xml'        : ['xmllint'],
	  \'toml'       : ['dprint'],
	  \'json'       : ['eslint'],
	  \'md'         : ['dprint'],
	  \'xsd'        : ['xmllint'],
	  \'matlab'     : ['mlint'],
	  \'sql'        : ['sqlformat'],
	  \'r'          : ['styler'],
  \}
  let g:ale_fix_on_save_ignore = {
	  \'html'       : ['html-beautify'],
	  \'javascript' : ['eslint'],
	  \'css'        : ['stylelint', 'prettier'],
	  \'c'          : ['clang-format'],
	  \'cpp'        : ['clang-format'],
	  \'cs'         : ['dotnet-format'],
	  \'python'     : ['isort', 'ruff', 'autopep8', 'comment_case'],
	  \'go'         : ['golint'],
	  \'xml'        : ['xmllint'],
	  \'toml'       : ['dprint'],
	  \'json'       : ['eslint'],
	  \'md'         : ['dprint'],
	  \'xsd'        : ['xmllint'],
	  \'matlab'     : ['mlint'],
	  \'sql'        : ['sqlformat'],
	  \'r'          : ['styler'],
  \}
  let g:ale_fixers_explicit = 1
  let g:ale_fix_on_enter = 0
  let g:ale_fix_on_save = 1
  let g:ale_javascript_prettier_use_local_config = 0
  let g:ale_sql_pgformatter_options = "--spaces 4 --comma-break --function-case 1 --keyword-case 1 --type-case 1"
  let g:ale_python_black_options = '--line-length 88 --skip-string-normalization'
  let g:ale_cpp_clangformat_options = '--style="{IndentWidth: 4, ColumnLimit: 79}"'
  let g:ale_c_clangformat_options = '--style="{IndentWidth: 4, ColumnLimit: 79}"'
  let g:ale_html_beautify_options = '--indent-size 2'
  let g:ale_dprint_use_global = 1
  let g:ale_python_isort_use_global = 1
  let g:ale_python_isort_options = '--settings-path ~/.editorconfig --known-local-folder=' . $CONFIG_ISORT_KNOWN_LOCAL_FOLDERS

  func! g:SqlformatFormatRange() range
	  exe ":'<,'> !sqlformat " . g:ale_sql_sqlformat_options
  endfunc
  au Filetype sql exec 'xnoremap <silent><buffer><leader>ja <Esc>:call SqlformatFormatRange()<cr>'

  func! g:BlackformatFormatRange() range
    exe ":'<,'> !black-macchiato " . g:ale_python_black_options
  endfunc
  au Filetype python exec 'xnoremap <silent><buffer><leader>jb <Esc>:call BlackformatFormatRange()<cr>'

  func! g:YapfformatFormatRange() range
	  exe ":'<,'> !yapf-rangef "
  endfunc
  au Filetype python exec 'xnoremap <silent><buffer><leader>jy <Esc>:call YapfformatFormatRange()<cr>'

endif
