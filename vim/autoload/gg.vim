function! gg#GG(cmd, args)
    redraw
    echo "Searching ..."

    " If no pattern is provided, search for the word under the cursor
    if empty(a:args)
        let l:grepargs = expand("<cword>")
    else
        let l:grepargs = a:args . join(a:000, ' ')
    end
    let l:ggprg_run = g:ggprg

    " Format, used to manage column jump
    let g:ggformat="%f:%l:%c:%m,%f:%l:%m"

    let grepprg_bak = &grepprg
    let grepformat_bak = &grepformat
    let &grepprg=l:ggprg_run
    let &grepformat=g:ggformat

    try
        " NOTE: we escape special chars, but not everything using shellescape
        " to allow for passing arguments etc
        if g:gg_use_dispatch
            let &l:errorformat = g:ggformat
            let &l:makeprg=g:ggprg." " . escape(l:grepargs, '|#%')
            Make
        else
            silent execute a:cmd . " " . escape(l:grepargs, '|#%')
        endif
    finally
        let &grepprg=grepprg_bak
        let &grepformat=grepformat_bak
    endtry

    if a:cmd =~# '^l'
        let s:handler = g:gg_lhandler
        let s:apply_mappings = g:gg_apply_lmappings
        let s:close_cmd = ':lclose<CR>'
    else
        let s:handler = g:gg_qhandler
        let s:apply_mappings = g:gg_apply_qmappings
        let s:close_cmd = ':cclose<CR>'
    endif

    if !g:gg_use_dispatch
        call gg#show_results()
    else
        copen
    endif
    call <SID>apply_maps()
    call <SID>highlight(l:grepargs)

    redraw!
endfunction

function! gg#show_results()
  execute s:handler
endfunction

function! s:apply_maps()
    let g:gg_mappings.q = s:close_cmd

    execute "nnoremap <buffer> <silent> ? :call gg#quick_help()<CR>"

    if s:apply_mappings && &ft == "qf"
        if g:gg_autoclose
            for key_map in items(g:gg_mappings)
                execute printf("nnoremap <buffer> <silent> %s %s", get(key_map, 0), get(key_map, 1) . s:close_cmd)
            endfor
            execute "nnoremap <buffer> <silent> <CR> <CR>" . s:close_cmd
        else
            for key_map in items(g:gg_mappings)
                execute printf("nnoremap <buffer> <silent> %s %s", get(key_map, 0), get(key_map, 1))
            endfor
        endif

        if exists("g:ggpreview") " if auto preview in on, remap j and k keys
            execute "nnoremap <buffer> <silent> j j<CR><C-W><C-W>"
            execute "nnoremap <buffer> <silent> k k<CR><C-W><C-W>"
        endif
    endif
endfunction

function! gg#quick_help()
    help gg_quick_help
endfunction

function! s:highlight(args)
    if !g:gghighlight
        return
    endif

    let @/ = matchstr(a:args, "\\v[^-]{1,2}\\s\\zs\\w+\>|['\"]\\zs.{-}\\ze['\"]")
    call feedkeys(":let &l:hlsearch=1 \| echo \<CR>", "n")
endfunction

function! gg#GGFromSearch(cmd, args)
    let search = getreg('/')
    " Translate vim regular expression to perl regular expression.
    let search = substitute(search, '\(\\<\|\\>\)', '\\b', 'g')
    call gg#GG(a:cmd, '"' . search . '" ' . a:args)
endfunction
