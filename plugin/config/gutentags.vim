" Explaining --fields=+ailmnS (info gathered from: $ ctags --list-fields)
" a: Access (or export) of class members
" i: Inheritance information
" l: Language of input file containing tag
" m: Implementation information
" n: Line number of tag definition
" S: Signature of routine (e.g. prototype or parameter list)
let g:gutentags_modules = ['ctags']
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['.root', '.fzf']
let g:gutentags_cache_dir = expand('~/.cache/tags')
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_ctags_tagfile = 'tags'
let g:gutentags_trace = 0
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')

" exclude gitignore
if executable('rg')
    let g:gutentags_file_list_command = 'rg --files'
else
    let g:gutentags_file_list_command = {
      \ 'markers': {
      \ '.git': 'bash -c "git ls-files; git ls-files --others --exclude-standard"',
      \ },
      \ }
endif
