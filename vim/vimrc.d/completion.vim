" Complete identifier if the cursor is after a keyword character. Otherwise,
" insert a normal tab.
function! TabOrComplete()
  let col = col('.')-1
  if !col || getline('.')[col-1] !~ '\k'
    return "\<Tab>"
  else
    return "\<C-N>"
  endif
endfunction
inoremap <Tab> <C-R>=TabOrComplete()<CR>
