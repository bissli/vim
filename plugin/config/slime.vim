let g:slime_target = "vimterminal"
let g:slime_vimterminal_config = {"term_finish": "close"}
let g:slime_paste_file = expand($HOME . '/.slime_paste')
let g:slime_no_mappings = 1
let g:slime_cell_delimiter = "^#\\s*%%"
let g:slime_cells_no_highlight = 1

au FileType javascript let b:slime_vimterminal_cmd = "node"
au FileType julia let b:slime_vimterminal_cmd = "julia"
au FileType python let b:slime_vimterminal_cmd = "ipython"
au FileType r let b:slime_vimterminal_cmd = "r"

func! SlimeMappings()
	nmap <silent><leader>se <Plug>SlimeCellsSendAndGoToNext
  xmap <silent><leader>se <Plug>SlimeRegionSend
	nmap <silent><leader>t :botright vert term ++close<cr>ipython<cr>%clear<cr><C-w><C-w><Plug>SlimeConfig
endfunc

au FileType javascript,julia,python,r call SlimeMappings()

if g:slime_cells_no_highlight
  func! SetCellHighlighting()
    let regex_cell = g:slime_cell_delimiter
    let match_cmd = "syntax match SlimeCell \"" . regex_cell . "\""
    let highlight_cmd = "highlight SlimeCell ctermfg=255 guifg=#b9b9b9 ctermbg=022 guibg=#3e3e5e cterm=bold gui=bold"
    if !hlexists('SlimeCell')
      execute highlight_cmd
    endif
    execute match_cmd
  endfunc
  au BufEnter *.py :call SetCellHighlighting()
endif
