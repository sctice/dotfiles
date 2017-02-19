" Use `jsl-vim` to check files for errors.
setlocal makeprg=jsl-vim\ %\ 2>/dev/null
setlocal errorformat=%f\:%l\ %m
