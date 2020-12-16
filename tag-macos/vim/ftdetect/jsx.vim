"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim ftdetect file
"
" Language: JSX (JavaScript)
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:jsx_pattern = '^import\s\+\<React\>'

" Whether to set the JSX filetype on *.js files.
fu! <SID>EnableJSX()
  let b:react_found = search(s:jsx_pattern, 'npw')
  return b:react_found
endfu

autocmd! BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd! BufNewFile,BufRead *.js
  \ if <SID>EnableJSX() | set filetype=javascript.jsx | endif
