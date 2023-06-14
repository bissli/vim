"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" => lint
let g:ale_linters = {
	\'javascript': ['eslint'],
	\'python': ['flake8', 'pylint', 'pyflakes'],
	\'go': ['go', 'golint', 'errcheck'],
	\'cpp': ['clangtidy'],
	\'cs': ['OmniSharp'],
	\'c': ['clangtidy'],
	\'tex': ['chktex'],
	\'matlab': ['mlint'],
\} " mypy
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
" autopep8
let g:pep8_select_warnings = 'W601,W602,W603,W604,W605,W690'
let g:pep8_select_errors = 'E101,E11'
let g:pep8_ignore_warnings = 'W503,W504'
let g:pep8_ignore_errors = 'E121,E124,E126,E128,E201,E203,E221,E222,E231,E241,E251,E272,E301,E402,E501,E722'
let g:pep8_ignore_mypy = 'S001,B005,B006,B007,B008,B009,B010,B011,B015,B301'
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
"   E722 do not use bare 'except'
"   W501 line too long
"   W503 line break occurred before a binary operator
"   W504 module level importnot at top of file
"   S001, B005, B006, B007, B008, B009, B010, B011, B015, B301 (for mypy compatability)
let g:pep8_ignore = 'E121,E124,E126,E128,E201,E203,E221,E222,E231,E241,E251,E272,E301,E402,E722,E501,W503,W504,S001,B005,B006,B007,B008,B009,B010,B011,B015,B301'

let g:ale_python_flake8_options='--ignore='.pep8_ignore.' --max-line-length=88'
let g:ale_python_pylint_options='--disable=all --enable=F,E,unused-variable,unused-import,unreachable,duplicate_key,wrong-import-order,unecessary-pass'

let g:ale_python_mypy_show_notes = 1
" let g:ale_python_mypy_options = '--ignore-missing-imports'

" => fix / format

function! FormatBlue(buffer) abort
    return {
    \   'command': 'blue --line-length 119 -'
    \}
endfunction

function PythonDocFormatter(buffer) abort
    return {
    \   'command': 'docformatter --black -'
    \}
endfunction

let g:ale_sql_sqlformat_options = join(['',
	\'--reindent',
	\'--indent_width '.shiftwidth().'',
	\'--keywords lower',
	\'--identifiers lower -'], ' ')
function SqlFormatFormatter(buffer) abort
    return {
    \   'command': 'sqlformat ' . g:ale_sql_sqlformat_options
    \}
endfunction


execute ale#fix#registry#Add('blue', 'FormatBlue', ['python'], 'blue formatter for python')
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
	\'python'     : ['docformatter', 'blue', 'autoflake', 'isort'],
	\'go'         : ['golint'],
	\'xml'        : ['xmllint'],
	\'xsd'        : ['xmllint'],
	\'matlab'     : ['mlint'],
	\'sql'        : ['sqlformat']
\}
let g:ale_fixers_explicit = 1
let g:ale_fix_on_save_ignore = 1
let g:ale_fix_on_enter = 0
let g:ale_javascript_prettier_use_local_config = 0
let g:ale_sql_pgformatter_options = "--spaces 4 --comma-break --function-case 1 --keyword-case 1 --type-case 1"
let g:ale_python_autopep8_options = '--ignore '.pep8_ignore.' --max-line-length 88'
let g:ale_python_autoflake_options = "--remove-all-unused-imports --expand-star-imports --ignore-init-module-imports"
let g:ale_python_pydocstyle_options = '--max-line-length=119 --convention=numpy --add-ignore=D100,D101,D102,D103,D104,D105,D106,D107,D202'
let g:ale_python_black_options = '--line-length 119 --skip-string-normalization --preview'
let g:ale_python_isort_options = '-m=8'
let g:ale_cpp_clangformat_options = '--style="{IndentWidth: 4, ColumnLimit: 119}"'
let g:ale_c_clangformat_options = '--style="{IndentWidth: 4, ColumnLimit: 119}"'
let g:ale_html_beautify_options = '--indent-size 2'

func! g:SqlformatFormatRange() range
	exe ":'<,'> !sqlformat " . g:ale_sql_sqlformat_options
endfunc

au Filetype sql exec 'xnoremap <silent><buffer><leader>ff <Esc>:call SqlformatFormatRange()<cr>'
