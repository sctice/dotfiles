" This is a (slightly) customized version of the file:line script by Victor
" Bogado da Silva Lins, last fetched from:
"
"     http://www.vim.org/scripts/script.php?script_id=2184
"
" on 4 June 2014. This version doesn't require that the line/column number be
" the last thing in the file name and will throw away anything after the first
" instance of a colon followed by a number, and optionally another colon and
" number.

if exists('g:loaded_file_line') || (v:version < 700)
    finish
endif
let g:loaded_file_line = 1

function! s:gotoLine()
    let file = bufname("%")

    " :e command calls BufRead even though the file is a new one.
    " As a workarround Jonas Pfenniger<jonas@pfenniger.name> added an
    " AutoCmd BufRead, this will test if this file actually exists before
    " searching for a file and line to goto.
    if (filereadable(file))
        return
    endif

    " Accept file:line or file:line:column
    let m = matchlist(file, '\v([^:]+):(\d+)%(:(\d+))?')

    if empty(m)
        return
    endif

    let file_name = m[1]

    if filereadable(file_name)
        let line_num = m[2] == '' ? '0' : m[2]
        let col_num = m[3] == '' ? '0' : m[3]

        let bufn = bufnr("%")
        exec ":bwipeout " bufn

        exec "keepalt edit " . file_name
        exec ":" . line_num
        exec "normal! " . col_num . '|'
        if foldlevel(line_num) > 0
            exec "normal! zv"
        endif

        exec "normal! zz"
    endif
endfunction

autocmd! BufNewFile *:* nested call s:gotoLine()
autocmd! BufRead *:* nested call s:gotoLine()
