" TODO: vars make local to script

function platform#detect()
  let g:platform = 0
  let g:distro = 0
  let g:uname = substitute(system('uname'), '\n\+$', '', '')
  let g:slash='/'
  if filereadable('/etc/debian_version')
      let g:platform='Linux'
      if !empty(system("grep -F -i 'Microsoft' '/proc/version' 2>/dev/null"))
        let g:distro='WSL'
      else
        let g:distro='Debian'
      endif
  elseif has('mac')
      let g:platform='Darwin'
      let g:distro='OS X'
      if has('transparency') && has('odbeditor') && has('gui_running')
        let g:distro='MacVim'
      endif
  elseif exists('g:uname') && g:uname ==# 'FreeBSD'
      let g:platform='FreeBSD'
      let g:distro='FreeBSD'
  elseif has('unix')
      let g:platform='UNIX'
  elseif has('win32') || has('win64') "win32 also matches on win64 so redundant
      let g:platform='Windows'
      let g:slash='\'
  elseif has('win32unix')
      let g:platform='Cygwin'
  else
      let g:platform='Unknown'
  endif
endfunction
" ^ combine the two
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n\+$', '', '')
    endif
endif
