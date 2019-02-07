function! SetupIfixit()
  TabLocal 3
endfunction

autocmd! BufNewFile,BufRead */{Code,Checkouts}/* call SetupIfixit
