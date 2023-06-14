let g:jupytext_fmt = 'py:percent'
let s:cell_markers = '\"\"\"'
let s:update_meta = '{"jupytext": {"cell_markers": "' . s:cell_markers . '"}}'
let g:jupytext_opts = '--update-metadata ' . "'" . s:update_meta . "'"
