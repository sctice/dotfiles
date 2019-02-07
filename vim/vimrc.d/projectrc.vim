" Each project def should set up autocmds that change local settings.

" Get files, ignoring 'suffixes' and 'wildignore', as a list.
let s:project_defs_pat = "~/.vim/project.d/*.vim"
let s:project_defs = glob(s:project_defs_pat, 1, 1)

for s:project_def in s:project_defs
  exec "source " . s:project_def
endfor
