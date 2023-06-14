let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'

" background color = editor color
set signcolumn=number

" diff preview
func! ToggleGitGutterPreviewHunk() abort
	" does nothing if that command doesn't exist
	if !exists(':GitGutterPreviewHunk')
		return 0
	endif
	" loop through all the windows in the current tab page
	for win in range(1, winnr('$'))
		" " is it a preview window?
		let preview_window = getwinvar(win, '&previewwindow') ? win : 0
	endfor
	" we have a preview window
	if preview_window > 0
		" " close the preview window
		pclose
	" we don't have a preview window
	else
		" open the preview window
		GitGutterPreviewHunk
	endif
endfunc
