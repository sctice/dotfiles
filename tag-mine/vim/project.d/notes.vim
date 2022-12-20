function! MoveToDone()
  let line = shellescape(getline("."))
  let path = expand("%:p:h") . "/done.md"
  call system("add-to-done " . l:line . " " . l:path)
  delete
endfunction

function! InsertDatedHeading()
  let ts = strftime("%Y-%m-%d")
  exec "normal! I## " . l:ts
  exec "normal! a\<CR>\<C-o>k\<C-o>o\<CR>\<CR>\<C-o>k"
endfunction

function! SetupNotes()
  nnoremap <Leader>nd :call MoveToDone()<CR>
  nnoremap <Leader>nl :call InsertDatedHeading()<CR>i
  " Replace current markdown list item text with 'nil'
  noremap <Leader>nn :s/^ *\([ *-]\\|\d\.\) .*/\1 nil<CR>
endfunction
autocmd! VimEnter,WinEnter,DirChanged */Sync/{Brain,iFixit}/* call SetupNotes()
