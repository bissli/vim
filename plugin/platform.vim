if &cp || (exists("g:loaded_config_platform") && !exists('g:force_reload_config_platform'))
  finish
endif
let s:cpo_save=&cpo
set cpo&vim

function platform#detect()
  let g:os='Linux'
  if has("win64") || has("win32") || has("win16")
      let g:os = "Windows"
  elseif has('win32unix')
      let g:os='Linux/Windows'
  elseif has('mac')
      let g:os='Linux/Darwin'
  elseif filereadable('/etc/debian_version')
      if !empty(system("grep -F -i 'Microsoft' '/proc/version' 2>/dev/null"))
        let g:os='Linux/WSL'
      else
        let g:os='Linux'
      endif
  endif
endfunction


let &cpo=s:cpo_save
