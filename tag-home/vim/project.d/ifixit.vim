function! SetupIfixit()
  TabLocal 3
endfunction

" Various repos under Projects/ifixit/.
autocmd! BufNewFile,BufRead */Projects/ifixit/* call SetupIfixit()

" Same setup for editing files on Cominor over SCP.
autocmd! BufNewFile,BufRead scp://com/{Code,Checkouts}/* call SetupIfixit()

" Provide a convenient search when we're in our queries repo.
function! SetupIfixitQueries()
  if getcwd() =~# '/ifixit/queries$'
    command! -nargs=+ SQL CG ./findsql <args>
  endif
endfunction

autocmd! VimEnter,WinEnter,DirChanged * call SetupIfixitQueries()
