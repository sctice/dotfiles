" Set up tab expansion to a specific number of spaces per tab, either locally
" or globally. It would be nice if we could just set 'tabstop' and have
" 'shiftwidth' and 'softtabstop' respect that setting, but some indent scripts
" explicitly set 'shiftwidth' and 'softtabstop' to values other than 0, which
" breaks the default behavior.
function! SetTabbing(spaces_per_tab, setcmd)
  execute a:setcmd . " shiftwidth=" . a:spaces_per_tab
  execute a:setcmd . " tabstop=" . a:spaces_per_tab
  execute a:setcmd . " softtabstop=" . a:spaces_per_tab
endfunction

command! -nargs=1 Tab call SetTabbing(<args>, "set")
command! -nargs=1 TabLocal call SetTabbing(<args>, "setlocal")

" Default indentation.
Tab 2
