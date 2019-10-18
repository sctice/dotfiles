" Loading color schemes and setting the background color clear out existing
" highlights, so in order to define our own highlights that will stick as we
" change the background or color scheme, we need to re-run them each time a
" color scheme is loaded using an autocmd. The function helps us keep
" everything tidy.
"
" https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
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
