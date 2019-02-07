" Configure Ctrl-P, which we primarily use for switching between buffers and as
" a fallback in the case that fzf isn't available.
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_lazy_update = 150
let g:ctrlp_match_window = 'bottom,order:ttb,min:10,max:10,results=30'
let g:ctrlp_max_files = 0
let g:ctrlp_open_new_file = 't'
let g:ctrlp_working_path_mode = 0

" Use native methods to find files.
if has("unix")
  let g:ctrlp_user_command = {
  \   'types': {
  \     1: [
  \       '.git',
  \       'git ls-files -co
  \         --exclude-standard %s
  \         | squelch'
  \     ]
  \   },
  \   'fallback': 'find %s -type f'
  \ }
endif

" Quick access to Ctrl-P's buffer filter.
noremap <Leader>b :CtrlPBuffer<CR>
