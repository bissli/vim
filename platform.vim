function platform#detect()
  let g:slash='/'
  if has("win64") || has("win32") || has("win16")
      let g:os = "Windows"
      let g:slash='\'
  elseif has('win32unix')
      let g:os='Cygwin'
  elseif filereadable('/etc/debian_version')
      if !empty(system("grep -F -i 'Microsoft' '/proc/version' 2>/dev/null"))
        let g:os='WSL'
      else
        let g:os='Debian'
      endif
  elseif has('mac')
      let g:os='Darwin'
  elseif substitute(system('uname'), '\n\+$', '', '') ==# 'FreeBSD'
      let g:os='FreeBSD'
  elseif has('unix')
      let g:os='UNIX'
  else
      let g:os='Unknown'
  endif
endfunction
