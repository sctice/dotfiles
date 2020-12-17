" Don't conceal markup
let g:pencil#conceallevel = 0

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd
    \ call pencil#init({'wrap': 'soft'})
  autocmd Filetype git,gitsendemail,*commit*,*COMMIT*
    \ call pencil#init({'wrap': 'hard', 'textwidth': 72})
augroup END
