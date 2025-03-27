if PlugLoaded('vim-gitgutter')

  let g:gitgutter_sign_added = '+'
  let g:gitgutter_sign_modified = '>'
  let g:gitgutter_sign_removed = '-'
  let g:gitgutter_sign_removed_first_line = '^'
  let g:gitgutter_sign_modified_removed = '<'

  " background color = editor color
  set signcolumn=number

  " Performance optimizations
  let g:gitgutter_max_signs = 2000
  let g:gitgutter_realtime = 0
  let g:gitgutter_eager = 0

  " Increase time between updates (milliseconds)
  let g:gitgutter_terminal_reports_focus = 0

  " Disable for large files
  let g:gitgutter_max_file_size = 1024 * 1024  " 1MB

  " Check file size before enabling gitgutter
  function! s:DisableGitGutterIfLargeFile()
    let l:file_size = getfsize(expand('%'))
    if l:file_size > g:gitgutter_max_file_size || l:file_size == -2
      GitGutterBufferDisable
      if &verbose > 0
        echo "GitGutter disabled for large file"
      endif
    endif
  endfunction

  augroup GitGutterOptimize
    autocmd!
    autocmd BufReadPre * call s:DisableGitGutterIfLargeFile()
    " Use a longer updatetime when not in insert mode
    autocmd InsertEnter * let g:gitgutter_old_updatetime = &updatetime | set updatetime=1000
    autocmd InsertLeave * let &updatetime = g:gitgutter_old_updatetime
  augroup END

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

  au BufEnter *.ipynb exe "GitGutterBufferDisable"

endif
