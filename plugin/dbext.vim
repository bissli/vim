" => dbext
let g:dbext_default_profile_psql = 'type=PGSQL:host=$PGHOST:port=$PGPORT:dbname=$PGDATABASE:user=$PGUSER'
let g:dbext_default_profile_ssql = 'type=SQLSRV:srvname='.$SQLHOST.':user='.$SQLUSER.':passwd='.$SQLPASSWORD.':dbname='.$SQLDATABASE
let g:dbext_default_profile = 'psql'
let g:dbext_default_SQLSRV_bin = 'sqlcmd'
let g:dbext_default_SQLSRV_cmd_options = '-m 1 -V 1'
let g:dbext_default_buffer_lines = 25
let g:dbext_default_job_enable = 0
let s:dbext_profiles = ['psql', 'ssql']
let s:current_profile_number = 0
au Filetype python,sql,buffer xmap <buffer> <leader>se <Plug>DBExecVisualSQL
au Filetype python,sql,buffer nmap <buffer> <leader>se <Plug>DBExecVisualSQL
func! NextDbextProfile()
    " Reset current_profile_number if too high
    if s:current_profile_number >= len(s:dbext_profiles)
        let s:current_profile_number = 0
    endif
    let l:exec_string = ':DBSetOption profile=' . s:dbext_profiles[s:current_profile_number]
    echo l:exec_string
    execute l:exec_string
    let s:current_profile_number = s:current_profile_number + 1
endfunc
au Filetype sql,buffer noremap <silent> <leader>sw <esc> :call NextDbextProfile()<cr>
" au VimEnter * DBCompleteTables
" vmap <silent><Leader>r :!psql -e<cr><cr>
" https://www.postgresql.org/docs/current/libpq-envars.html

