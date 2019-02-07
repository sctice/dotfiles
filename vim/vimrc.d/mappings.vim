" Mappings of various sorts, broken out into sections by mode.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Normal

" Various broadly-applicable leader-triggered actions in alphabetical order,
" lowercase before uppercase.

" Toggle auto-formatting of paragraphs.
function! ToggleAutoFormat()
  let fopts = &formatoptions
  if stridx(fopts, 'a') >= 0
    setlocal formatoptions-=a
  else
    setlocal formatoptions+=a
  endif
  setlocal formatoptions?
endfunction
noremap <Leader>a :call ToggleAutoFormat()<CR>

" Toggle highlighting of the last search.
noremap <Leader>h :set hlsearch! hlsearch?<CR>

" Toggle paste mode.
noremap <Leader>p :set paste! paste?<CR>

" Toggle relative numbering and normal line numbering
noremap <Leader>r :set relativenumber!<CR>

" Yank the entire document to the clipboard.
noremap <Leader>Y :%yank+<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command

" Command-line editing (loosely) like bash/emacs.
cnoremap <C-A>  <Home>
cnoremap <Esc>b <C-Left>
cnoremap <Esc>f <C-Right>
cnoremap <C-U>  <C-E><C-U>
cnoremap <C-G>  <C-C>
