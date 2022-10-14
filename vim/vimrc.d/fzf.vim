" Add FZF's built-in vim plugin for fuzzily finding files.
let s:fzf_path = expand("~/.local/lib/fzf")
if isdirectory(s:fzf_path)
  set runtimepath+=~/.local/lib/fzf
  noremap <Leader>f :let $flist_git_noexclude = '' \| :FZF<CR>
  noremap <Leader>F :let $flist_git_noexclude = 1 \| FZF<CR>
endif
