" => vim-autoformat,vim-yapf-format
" noremap <leader>f :Autoformat<cr>
" let g:autoformat_autoindent = 0
" let g:autoformat_retab = 0
" let g:autoformat_remove_trailing_spaces = 0
" let g:autoformat_verbosemode = 1

" " Python
" let g:formatters_python = ['yapf']
" " let g:pyformat=join(['{',
						" " \'based_on_style: google,',
						" " \'indent_width: '.shiftwidth().',',
						" " \'column_limit: '.&textwidth.'',
					" " \'}'], ' ')
" " let g:formatdef_yapf='"yapf --style=''".g:pyformat."'' -l ".a:firstline."-".a:lastline'

" " HTML/XML
" let g:formatdef_tidy_html = "'tidy -iq -wrap 0 --indent-spaces 4'"
" let g:formatdef_tidy_xml = "'tidy -iq -xml -wrap 0 --indent-spaces 2'"
