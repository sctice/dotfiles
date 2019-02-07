" Allow a local vimrc set up by rcm to override preceding settings.

let s:local_path = expand("~/.local/etc/vimrc.local")

if filereadable(s:local_path)
  exec "source " . s:local_path
endif
