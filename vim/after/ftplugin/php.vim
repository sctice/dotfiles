" We need to do this because the runtime ftplugin/php.vim sources the runtime
" ftplugin/html.vim, which sets 'comments', overriding anything done by the PHP
" indent scripts. Putting this in ftplugin/ (not 'after') does not suffice.
"
" We also add support for javadoc-style comments with two asterisks as the
" opening. This is required to prevent auto-formatting from joining the first
" line of text in a javadoc-style comment with the comment opener ('/**' on a
" line of its own). The specification for this style of comment must come
" before the specification for '/*' because '/*' will match a comment that
" starts with '/**' but won't prevent the undesired auto-formatting behavior.
setlocal comments=s1:/**,mb:*,ex:*/,s1:/*,mb:*,ex:*/,://,b:#

" Don't use smartindent; rely on PHP indent for smart indenting.
setlocal autoindent
