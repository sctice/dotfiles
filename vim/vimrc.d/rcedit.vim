" Open vimrc.
noremap <Leader>v :edit $MYVIMRC<CR>

" Source the vimrc file when it's written
autocmd! BufWritePost */.?vim/* source $MYVIMRC
