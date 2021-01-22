"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" pencil

" Don't conceal markup
let g:pencil#conceallevel = 0

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd
    \ call pencil#init({'wrap': 'soft'})
  autocmd Filetype git,gitsendemail,*commit*,*COMMIT*
    \ call pencil#init({'wrap': 'hard', 'textwidth': 72})
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-markdown

" Folding is SLOW, and I don't use it anyways.
let g:vim_markdown_folding_disabled = 1
" I don't care about concealing markdown syntax, so why pay the cost?
let g:vim_markdown_conceal = 0
