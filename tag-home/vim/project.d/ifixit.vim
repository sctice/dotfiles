function! SetupIfixit()
  TabLocal 3
endfunction

" Various repos under Projects/ifixit/.
autocmd! BufNewFile,BufRead */Projects/ifixit/* call SetupIfixit()

" Same setup for editing files on Cominor over SCP.
autocmd! BufNewFile,BufRead scp://com/{Code,Checkouts}/* call SetupIfixit()
