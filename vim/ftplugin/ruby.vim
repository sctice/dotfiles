" By convention, ruby code uses 2 spaces of indent.
setlocal ts=2 sw=2 sts=2

" Use `ruby -c` to check files for errors.
setlocal makeprg=ruby\ -c\ %\ 2>/dev/null\ \\\|\ grep\ -v\ '^Syntax\ OK'
setlocal errorformat=%f:%l\ %m
