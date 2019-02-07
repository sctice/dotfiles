" Load Vundle bundles
let s:bundles_path = expand("~/.local/etc/vimrc.bundles")
if filereadable(s:bundles_path)
  exec "source " . s:bundles_path
endif
