" Calling :colorscheme appears to override automatic detection of the
" background color and simply default to a light background. This gives us an
" easy way to specify a lasting override without pushing a config change. On
" startup, we set 'background' from ~/.local/var/vimbg (if it exists and the
" first line is either 'light' or 'dark'). The sticky setting can be changed
" with `:BG dark|light` (replaces the file contents).

let s:vimbg = expand('~/.local/var/vimbg')

function! SetVimbg(bg)
  if a:bg !~ "^dark\\|light$"
    echoerr 'Background must be "light" or "dark"'
    return
  endif
  call writefile([a:bg], s:vimbg)
  call SetBackgroundFromVimbg()
endfunction
command! -nargs=1 BG call SetVimbg('<args>')

function! SetBackgroundFromVimbg()
  if filereadable(s:vimbg)
    let l:bg = readfile(s:vimbg, '', 1)
    if len(l:bg) && l:bg[0] =~ '^dark\|light$'
      exec 'set background=' . l:bg[0]
    endif
  endif
endfunction
call SetBackgroundFromVimbg()

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

" Set up our preferred color scheme.

colo PaperColor
