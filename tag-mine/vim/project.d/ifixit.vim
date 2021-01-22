" Various repos under Projects/ifixit/.
autocmd! BufNewFile,BufRead */Projects/ifixit/* TabLocal 3

" But Stats uses an indent of 2.
autocmd! BufNewFile,BufRead */Projects/ifixit/Stats/* TabLocal 2

" Editing files on Cominor over SCP uses the standard iFixit indent.
autocmd! BufNewFile,BufRead scp://com/{Code,Checkouts}/* TabLocal 3

" Provide a convenient search when we're in our queries repo.
function! SetupIfixitQueries()
  if getcwd() =~# '/ifixit/sql$'
    command! -nargs=+ SQL CG ./findsql <args>
  endif
endfunction
autocmd! VimEnter,WinEnter,DirChanged * call SetupIfixitQueries()
