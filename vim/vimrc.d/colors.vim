function! ApplyCustomHighlights() abort
  " Highlight matching bracket to bracket under the cursor using something that
  " will work more often without being too distracting.
  highl MatchParen cterm=underline ctermfg=Red ctermbg=none

  " Remove the default underline that later versions of vim 8 add to the line
  " number when using relative numbering.
  hi CursorLineNr term=bold cterm=bold gui=bold
endfunction

augroup CustomHighlights
  autocmd!
  autocmd ColorScheme * call ApplyCustomHighlights()
augroup END

" Enforce the default color scheme.
colorscheme default
