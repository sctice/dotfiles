" Various broadly-applicable commands in alphabetical order.

" Delete all but the current buffer.
command! Bufonly silent! execute "%bd|e#|bd#"

" Use sudo to save the current file.
command! WW w !sudo tee % >/dev/null
