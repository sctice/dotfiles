" Slime, for interacting with REPLs.

" Use the native vim terminal for the REPL.
let g:slime_target = "vimterminal"

" Make use of IPython's %cpaste magic function to allow for robust pasting to
" overcome subtle whitespace issues.
let g:slime_python_ipython = 1

" Discard all of Slime's default mappings.
let g:slime_no_mappings = 1

xmap <leader>> <Plug>SlimeRegionSend
nmap <leader>> <Plug>SlimeParagraphSend
nmap <leader>{ <Plug>SlimeMotionSend
