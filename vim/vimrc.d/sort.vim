function! s:SortLinesOpFunc(...)
    '[,']sort
endfunction

nnoremap <silent> \s :<C-u>set operatorfunc=<SID>SortLinesOpFunc<CR>g@
