" The 'w' option is added by the system files, and it causes spaces to be left
" at the ends of lines when autoformatting. Highly annoying.
setlocal formatoptions-=w

" Use `php -l` to check files for errors. More recent versions of PHP include
" color escape codes in the output, which screws up errorformat. The sed
" command filters to errors on specific lines and removes color codes.
setlocal makeprg=php\ -l\ %\ 2>/dev/null\ \\\|\ sed\ -n\ '/on\ line/{s/\\x1B\\[[0-9;]\\+[A-Za-z]//g;p}'
setlocal errorformat=%m\ in\ %f\ on\ line\ %l

" Use K to look up PHP built-ins with pman.
if executable("pman")
  setlocal keywordprg=pman
endif

" Use some suggested mappings from Phpactor.
nmap <buffer> <Leader>u :PhpactorImportClass<CR>
nmap <buffer> <Leader>ua :PhpactorImportMissingClasses<CR>
nmap <buffer> <Leader>nn :PhpactorNavigate<CR>
nmap <buffer> <Leader>o  :PhpactorGotoDefinition edit<CR>
nmap <buffer> <Leader>r :PhpactorFindReferences<CR>
nmap <buffer> <silent> <Leader>ee :PhpactorExtractExpression<CR>
vmap <buffer> <silent> <Leader>ee :<C-u>PhpactorExtractExpression<CR>
