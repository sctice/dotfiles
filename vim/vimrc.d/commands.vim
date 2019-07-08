" Various broadly-applicable commands in alphabetical order.

" Delete all but the current buffer.
command! Bufonly silent! execute "%bd|e#|bd#"

" Much more convenient than typing out ':tabnew'.
command! -nargs=? T :tabnew <args>

" Use sudo to save the current file.
command! WW w !sudo tee % >/dev/null
