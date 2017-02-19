" Location of the gg utility
if !exists("g:ggprg")
    if executable('gg')
        let g:ggprg = "gg"
    else
        finish
    endif
    if !exists("g:gg_default_options")
        let g:gg_default_options = ''
    endif
    let g:ggprg .= ' ' . g:gg_default_options
endif

if !exists("g:gg_apply_qmappings")
    let g:gg_apply_qmappings = !exists("g:gg_qhandler")
endif

if !exists("g:gg_apply_lmappings")
    let g:gg_apply_lmappings = !exists("g:gg_lhandler")
endif

if !exists("g:gg_use_dispatch")
    let g:gg_use_dispatch = 0
end

let s:gg_mappings = {
    \ "t": "<C-W><CR><C-W>T",
    \ "T": "<C-W><CR><C-W>TgT<C-W>j",
    \ "o": "<CR>",
    \ "O": "<CR><C-W><C-W>:ccl<CR>",
    \ "go": "<CR><C-W>j",
    \ "h": "<C-W><CR><C-W>K",
    \ "H": "<C-W><CR><C-W>K<C-W>b",
    \ "v": "<C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t",
    \ "gv": "<C-W><CR><C-W>H<C-W>b<C-W>J" }

if exists("g:gg_mappings")
    let g:gg_mappings = extend(s:gg_mappings, g:gg_mappings)
else
    let g:gg_mappings = s:gg_mappings
endif

if !exists("g:gg_qhandler")
    let g:gg_qhandler = "botright copen"
endif

if !exists("g:gg_lhandler")
    let g:gg_lhandler = "botright lopen"
endif

if !exists("g:gghighlight")
    let g:gghighlight = 0
endif

if !exists("g:gg_autoclose")
    let g:gg_autoclose = 0
endif

if !exists("g:gg_autofold_results")
    let g:gg_autofold_results = 0
endif

command! -bang -nargs=* -complete=file GG           call gg#GG('grep<bang>', <q-args>)
command! -bang -nargs=* -complete=file GGAdd        call gg#GG('grepadd<bang>', <q-args>)
command! -bang -nargs=* -complete=file GGFromSearch call gg#GGFromSearch('grep<bang>', <q-args>)
command! -bang -nargs=* -complete=file LGG          call gg#GG('lgrep<bang>', <q-args>)
command! -bang -nargs=* -complete=file LGGAdd       call gg#GG('lgrepadd<bang>', <q-args>)
