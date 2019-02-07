" Enforce the default color scheme.
colorscheme default

" Customize the tab line colors so that it's easier (for me) to tell which tab
" is active.
highl TabLine term=none cterm=none ctermfg=White ctermbg=DarkGray
highl TabLineFill term=none cterm=none ctermfg=White ctermbg=DarkGray
highl TabLineSel ctermfg=Green

" Highlight matching bracket to bracket under the cursor using something that
" will work more often without being too distracting.
highl MatchParen cterm=underline ctermfg=Red ctermbg=none

" Spelling.
highl SpellBad cterm=undercurl ctermbg=none ctermfg=Red
highl SpellCap cterm=undercurl ctermbg=none ctermfg=DarkBlue
highl SpellRare cterm=undercurl ctermbg=none ctermfg=Brown
highl SpellLocal cterm=undercurl ctermbg=none ctermfg=DarkCyan
