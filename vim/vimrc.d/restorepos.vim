" Configure restorepos.vim. Don't remember positions in temporary git files
" used for things like commit messages, rebase todos, and so on. This covers
" *everything* in a .git directory, but the temporary files are by far the
" common case.
let g:restorepos_ignore = ['\v(^|/)\.git(/|$)']
