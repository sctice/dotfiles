" Open vimrc.
noremap <Leader>v :edit $MYVIMRC<CR>

" Source the vimrc file when it's written. The `nested` option allows vim to
" run other autocmds we've defined (specifically, custom colors).
autocmd! BufWritePost */.?vim/* nested source $MYVIMRC
