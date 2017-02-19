" Don't allow the default tex compiler to be used.
let current_compiler = "rubber"

" The default Makefile to be used when there's no project-specific Makefile.
let s:default_makefile = "~/.vim/makefiles/rubber.mk"

" Save compatability options.
let s:cpo_save = &cpo
set cpo-=C

if exists(":CompilerSet") != 2
    command! -nargs=* CompilerSet setlocal <args>
endif

" The basic error format for rubber-check, plus output lines from the execution
" of the makefile to ignore (everything after the first line).
CompilerSet errorformat =
    \%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m,
    \%-Grubber\ %.%#,
    \%-Gcompiling\ %.%#,
    \%-Grubber-info\ %.%#,
    \%-Gmake:\ %.%#,
    \%-Gfind\ %.%#,
    \%-Grm\ %.%#

if filereadable('Makefile')
    " Use the project-specific Makefile.
    setlocal makeprg=make
else
    " Use the default Makefile
    exec "setlocal makeprg=make" .
        \ "\\ -f\\ " . s:default_makefile .
        \ "\\ %<.pdf"
endif

" Restore compatability options.
let &cpo = s:cpo_save
unlet s:cpo_save
