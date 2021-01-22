" Mappings of various sorts, broken out into sections by mode.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Input

" Create 3 new lines and put the cursor in the middle one.
inoremap <C-J> <C-o>o<C-o>O<CR>
nnoremap <C-J> o<C-o>O<CR>

" Insert date stamps
inoremap <expr> xxds strftime("%Y%m%d%H%M%S")
inoremap <expr> xxd strftime("%Y-%m-%d")

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

" Toggle spell mode.
noremap <Leader>; :set spell! spell?<CR>

" Toggle relative numbering and normal line numbering
noremap <Leader>r :set relativenumber!<CR>

" Yank the entire document to the clipboard.
noremap <Leader>Y :%yank+<CR>

" I often forget which terminal tab I'm in, and then I try to do <C-b><C-b> to
" switch tmux panes, but that doesn't work because I'm not in tmux, and then
" the native vim <C-b> scrolls my position. I never intend to use vim's <C-b>,
" so map it to a no-op.
noremap <C-b> <nop>

" Configure key bindings for the quick fix window, managed by QFEnter.
let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command

" Command-line editing (loosely) like bash/emacs.
cnoremap <C-A>  <Home>
cnoremap <Esc>b <C-Left>
cnoremap <Esc>f <C-Right>
cnoremap <C-U>  <C-E><C-U>
cnoremap <C-G>  <C-C>
