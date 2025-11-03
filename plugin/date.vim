function! ConvertDatesToISOFormat()
  " Convert MM/DD/YYYY to YYYY-MM-DD
  %s/\v(\d{1,2})\/(\d{1,2})\/(\d{4})/\3-\1-\2/ge

  " Convert DD/MM/YYYY to YYYY-MM-DD
  %s/\v(\d{1,2})\/(\d{1,2})\/(\d{4})/\3-\2-\1/ge

  " Convert MM-DD-YYYY to YYYY-MM-DD
  %s/\v(\d{1,2})-(\d{1,2})-(\d{4})/\3-\1-\2/ge

  " Convert DD-MM-YYYY to YYYY-MM-DD
  %s/\v(\d{1,2})-(\d{1,2})-(\d{4})/\3-\2-\1/ge

  " Convert YYYY/MM/DD to YYYY-MM-DD
  %s/\v(\d{4})\/(\d{1,2})\/(\d{1,2})/\1-\2-\3/ge

  " Ensure single-digit months and days are zero-padded
  %s/\v(\d{4})-(\d{1})(\-)/\1-0\2\3/ge
  %s/\v(\d{4})-(\d{2})-(\d{1})$/\1-\2-0\3/ge
endfunction

" Add a command to call this function
command! ConvertDatesToISO call ConvertDatesToISOFormat()
