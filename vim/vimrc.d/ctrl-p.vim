" Configure Ctrl-P, which we primarily use for switching between buffers and as
" a fallback in the case that fzf isn't available.

" Only update after 150ms of no typing.
let g:ctrlp_lazy_update = 150

" Show up to 20 results.
let g:ctrlp_match_window = 'max:20'

" No limit on the number of files.
let g:ctrlp_max_files = 0

" When creating a new file, replace the current buffer.
let g:ctrlp_open_new_file = 'r'

" Always start from the current directory.
let g:ctrlp_working_path_mode = 0

" Use native methods to find files.
if has("unix")
  let g:ctrlp_user_command = {
  \   'types': {
  \     1: [
  \       '.git',
  \       'git ls-files -co
  \         --exclude-standard %s'
  \     ]
  \   },
  \   'fallback': 'find %s -type f'
  \ }
endif

" Quick access to Ctrl-P's buffer filter.
noremap <Leader>b :CtrlPBuffer<CR>

" Don't separate buffers into name and path. Just use the full path for the
" buffer name so that we can fuzzy match by path.
let g:ctrlp_bufname_mod = ':~:.'
let g:ctrlp_bufpath_mod = ''
