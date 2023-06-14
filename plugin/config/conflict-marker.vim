" => conflict-marker
let g:conflict_marker_highlight_group = '' 
let g:conflict_marker_enable_highlight = 1
let g:conflict_marker_enable_mappings = 1
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_separator = '^=======$'
let g:conflict_marker_end   = '^>>>>>>> .*$'

" [x and ]x mappings are defined as default for navigation
" ct -> theirs
" co -> ours
" cb -> both (ours, then theirs)
" cB -> both (theirs, then ours)
" cn -> none
