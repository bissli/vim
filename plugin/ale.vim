"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> [s <Plug>(ale_previous_wrap)
nmap <silent> ]s <Plug>(ale_next_wrap)
let g:ale_pattern_options = {
\   '.*\.md$': {'ale_enabled': 0},
\   '.*\.markdown$': {'ale_enabled': 0},
\   '.*\.rst$': {'ale_enabled': 0},
\   '.*\.txt$': {'ale_enabled': 0},
\   '.*\.tex$': {'ale_enabled': 0},
\	'\.min\.js$': {'ale_enabled': 0},
\	'\.min\.css$': {'ale_enabled': 0},
\}
" nmap <leader>a <Plug>(ale_lint)
let g:ale_enabled = 0
let g:ale_open_list = 0
let g:ale_set_signs = 1
" let g:ale_change_sign_column_color = 1
let g:ale_sign_error = "⇨"
let g:ale_sign_warning = "⇨"
let g:ale_set_highlights = 0

" => lint
nmap <leader>a <Plug>(ale_toggle)
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8', 'pylint', 'pyflakes', 'mypy'],
\   'go': ['go', 'golint', 'errcheck']
\}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_filetype_changed = 0
" " Don't warn on
"   E121 continuation line indentation is not a multiple of four
"   E124 closing bracket does not match visual indentation
"   E126 continuation line over-indented for hanging indent
"   E128 continuation line under-indented for visual indent
"   E201 whitespace after [
"   E221 multiple spaces before operator
"   E222 multiple spaces after operator
"   E231 missing whitespace asfter ':'
"   E241 multiple spaces after ':'
"   E251 unexpected spaces around keyword / parameter equals
"   E272 multiple spaces before keyword
"   E301 expected 1 blank line, found 0
"   W503 line break occurred before a binary operator
let g:ale_python_flake8_options='--ignore= E121,E124,E126,E128,E201,E221,E222,E231,E241,E251,E272,E301,W503 --max-line-length='.&textwidth
" let g:ale_python_pylint_options='--disable=all --enable=F,E,unused-variable,unused-import,anomalous-backslash-in-string,unreachable,duplicate_key,wrong-import-order,unecessary-pass'

" => fix / format
nmap <leader>f <Plug>(ale_fix)
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'html': ['prettier'],
\   'javascript': ['eslint', 'prettier'],
\   'css': ['stylelint', 'prettier'],
\   'python': ['yapf', 'isort'],
\   'go': ['golint'],
\   'xml': ['xmlformat'],
\}
" yapf style either in ~/.config/yapf/style or project [setup.cfg [yapf] or style.yapf]
let g:ale_fixers_explicit = 1
let g:ale_fix_on_save_ignore = 1
let g:ale_fix_on_enter = 0
let g:ale_javascript_prettier_use_local_config = 0
let g:ale_sql_pgformatter_options = "--spaces 2 --comma-break"
" custom sql formatter
let g:sqlformat = join(['sqlformat',
					   \'--reindent',
					   \'--indent_width '.shiftwidth().'',
					   \'--keywords lower',
					   \'--identifiers lower -'], ' ')
let g:formatdef_sqlformat="'".g:sqlformat."'"
func! SqlFmtDef() range
	exe ":'<,'> !".g:sqlformat
endfunc
au Filetype sql xnoremap <silent> <leader>f <esc> :call SqlFmtDef()<cr>
