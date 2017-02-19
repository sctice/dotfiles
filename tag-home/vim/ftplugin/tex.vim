" Set the compiler to rubber, which must be installed separately. Rubber is an
" external utility which must be installed on the system, and is actually run
" via a make file, which will either be specific to a project (i.e. a Makefile
" in the project directory) or the default makefile (at the specified
" location in compilers/rubber.vim).

compiler rubber
command! -buffer TexCount ! texcount.pl -nosub %
