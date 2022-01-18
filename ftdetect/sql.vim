au BufRead /tmp/psql.edit.* set filetype=sql
au BufRead /tmp/ssql.edit.* set filetype=sql
au BufRead,BufNewFile Result set filetype=sql
au BufFilePre,BufNewFile,BufRead buffer set filetype=sql
