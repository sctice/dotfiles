" Run a custom grep command that works like grep and outputs in a grep-like
" format via :grep, temporarily replacing the current grep grepprg.
function! CustomGrep(grepprg, ...)
  let prev_grepprg = &grepprg
  let grep_cmd = "silent grep! " . join(a:000, " ") . " | copen | redraw!"
  echo a:grepprg
  let &grepprg = a:grepprg
  execute grep_cmd
  let &grepprg = prev_grepprg
endfunction

" For example: :CG my-grep QUERY
command! -complete=file -nargs=+ CG call CustomGrep(<f-args>)

" PHP-specific command to search for subclasses of a base class (includes the
" base class as well).
if executable("subclasses")
  command! -complete=file -nargs=+ SC call CustomGrep("subclasses", <f-args>)
endif
