" The 'w' option is added by the system files, and it causes spaces to be left
" at the ends of lines when autoformatting. Highly annoying.
setlocal formatoptions-=w

" Use `php -l` to check files for errors.
setlocal makeprg=php\ -l\ %\ 2>/dev/null\ \\\|\ grep\ -E\ 'on\ line\ [0-9]+$'
setlocal errorformat=%m\ in\ %f\ on\ line\ %l

" Use K to look up PHP built-ins with pman.
if executable("pman")
  setlocal keywordprg=pman
endif
