"""Move me somewhere else

if exists("b:done_vimsnippets")
   finish
endif
let b:done_vimsnippets = 1

if !exists("g:snips_author")
    let g:snips_author = $USER
endif

if !exists("g:snips_email")
    let g:snips_email = "yourname@email.com"
endif

if !exists("g:snips_github")
    let g:snips_github = "https://github.com/yourname"
endif
