" Restore the cursor position to the line and column it was on the last time
" that the file was edited using data from the .viminfo file. The logic here
" came from somewhere, but I'm not sure where anymore.

if exists("g:loaded_restorepos")
    finish
endif
let g:loaded_restorepos = 1

if !exists("g:restorepos_ignore")
    let g:restorepos_ignore = []
endif

function! s:check()
    if has('quickfix') && &buftype =~ 'nofile' | return 0 | endif
    if expand('%') =~ '\[.*\]' | return 0 | endif

    let file_name = expand('%:p')
    for ifile in g:restorepos_ignore
        if file_name =~ ifile
            return 0
        endif
    endfor
    return 1
endfunction

function! s:restore()
    let restorepos = line("'\"")
    if restorepos >= 1 && restorepos <= line("$")
        normal! g`"
        normal! zz
    endif
endfunction

autocmd! BufWinEnter ?* if s:check() | silent call s:restore() | endif
