"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Shawn Tice, with lots of help from the internet.

set guioptions=Mm         " No toolbar in the gui; must be first in .vimrc
set nocompatible          " No compatibility with vi

filetype on               " Recognize syntax by file extension
filetype indent on        " Check for indent file
filetype plugin on        " Allow plugins to be loaded by file type
syntax on                 " Syntax highlighting

set autoindent            " By default, match indent of previous line
set backspace=2           " Allow <BS> to go past last insert
set colorcolumn=+1        " Draw a line to mark the text width visually
set cryptmethod=blowfish  " Use blowfish encryption instead of zip
set expandtab             " Expand tabs with spaces
set gdefault              " Assume :s uses /g
set hidden                " Allow hiding abandoned buffers
set ignorecase            " Ignore case in regular expressions
set incsearch             " Immediately highlight search matches
set laststatus=2          " Alsways show a status line
set modeline              " Check for a modeline
set noerrorbells          " No beeps on errors
set nofoldenable          " Disable folds; toggle with zi
set nohls                 " Don't highlight all regex matches
set nowrap                " Don't soft wrap
set number                " Number lines
set numberwidth=5         " Fixed-width line numbers
set previewheight=16      " Height of preview window (e.g., Gstatus)
set relativenumber        " Display line numbers relative to cursor pos
set ruler                 " Display row, column and % of document
set scrolloff=10          " Keep min of 10 lines above/below cursor
set showcmd               " Show partial commands in the status line
set showmode              " Show current mode
set smartcase             " Searches are case-sensitive if caps used
set splitright            " Default new vsplit to right
set splitbelow            " Default new hsplit to bottom
set textwidth=79          " Hard wrap at 79 characters
set vb t_vb=              " No visual bell
set virtualedit=block     " Allow the cursor to go where there's no char

" Be very explicit about auto-formatting options. See :help fo-table. Note that
" you can only subtract (-=) one option at a time. So fo-=tw wouldn't do
" anything.
set formatoptions+=croq2lj
set formatoptions-=t

" Display tabs and trailing spaces (requires UTF-8).
set list listchars=tab:»\ ,trail:·

" Patterns to ignore when tab-completing.
set wildignore+=*.o,*.d,*.pyc,*.class

" Complete longest common prefix and display a menu of matches; successive tabs
" cycle between completions. This applies to the command prompt.
set wildmode=list:longest

" Same as above, but for insert completion.
set completeopt=longest,menu

" Load Vundle bundles
let s:bundles_path = expand("~/.local/etc/vimrc.bundles")
if filereadable(s:bundles_path)
  exec "source " . s:bundles_path
endif

" Add FZF's built-in vim plugin for fuzzily finding files.
let s:fzf_path = expand("~/.local/lib/fzf")
if isdirectory(s:fzf_path)
  set runtimepath+=~/.local/lib/fzf
  noremap <Leader>f :FZF<CR>
endif

" Configure Ctrl-P, which we primarily use for switching between buffers and as
" a fallback in the case that fzf isn't available.
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_lazy_update = 150
let g:ctrlp_match_window = 'bottom,order:ttb,min:10,max:10,results=30'
let g:ctrlp_max_files = 0
let g:ctrlp_open_new_file = 't'
let g:ctrlp_working_path_mode = 0

" Use native methods to find files.
if has("unix")
  let g:ctrlp_user_command = {
  \   'types': {
  \     1: [
  \       '.git',
  \       'git ls-files -co
  \         --exclude-standard %s
  \         | squelch'
  \     ]
  \   },
  \   'fallback': 'find %s -type f'
  \ }
endif

" Quick access to Ctrl-P's buffer filter.
noremap <Leader>b :CtrlPBuffer<CR>

" Configure restorepos.vim. Don't remember positions in temporary git files
" used for things like commit messages, rebase todos, and so on. This covers
" *everything* in a .git directory, but the temporary files are by far the
" common case.
let g:restorepos_ignore = ['\v(^|/).git(/|$)']

" Enable matchit to let % bounce between more things.
runtime macros/matchit.vim

" Slime, for interacting with REPLs.
let g:slime_target = "vimterminal"
let g:slime_python_ipython = 1
let g:slime_no_mappings = 1
xmap <leader>s <Plug>SlimeRegionSend
nmap <leader>s <Plug>SlimeParagraphSend
nmap <leader>S <Plug>SlimeMotionSend

" Use sudo to save the current file.
command! WW w !sudo tee % >/dev/null

" Open a new, empty tab quickly.
command! T tabedit

" Set up tab expansion to a specific number of spaces per tab, either locally
" or globally. It would be nice if we could just set 'tabstop' and have
" 'shiftwidth' and 'softtabstop' respect that setting, but some indent scripts
" explicitly set 'shiftwidth' and 'softtabstop' to values other than 0, which
" breaks the default behavior.
function! SetTabbing(spaces_per_tab, setcmd)
  execute a:setcmd . " shiftwidth=" . a:spaces_per_tab
  execute a:setcmd . " tabstop=" . a:spaces_per_tab
  execute a:setcmd . " softtabstop=" . a:spaces_per_tab
endfunction
command! -nargs=1 Tab call SetTabbing(<args>, "set")
command! -nargs=1 TabLocal call SetTabbing(<args>, "setlocal")

" Run a custom grep command that works like grep and outputs in a grep-like
" format via :grep, temporarily replacing the current grep grepprg. For
" example: :CG subclasses Page
function! CustomGrep(grepprg, ...)
  let prev_grepprg = &grepprg
  let grep_cmd = "silent grep! " . join(a:000, " ") . " | copen | redraw!"
  echo a:grepprg
  let &grepprg = a:grepprg
  execute grep_cmd
  let &grepprg = prev_grepprg
endfunction
command! -complete=file -nargs=+ CG call CustomGrep(<f-args>)
command! -complete=file -nargs=+ SC call CustomGrep("subclasses", <f-args>)

" Yank the entire document to the clipboard.
noremap <Leader>Y :%yank+<CR>

" Toggle paste mode.
noremap <Leader>p :set paste! paste?<CR>

" Toggle auto-formatting of paragraphs.
function! ToggleAutoFormat()
  let fopts = &formatoptions
  if stridx(fopts, 'a') >= 0
    setlocal formatoptions-=a
  else
    setlocal formatoptions+=a
  endif
  setlocal formatoptions?
endfunction
noremap <Leader>a :call ToggleAutoFormat()<CR>

" Toggle highlighting of the last search.
noremap <Leader>h :set hlsearch! hlsearch?<CR>

" Toggle relative numbering and normal line numbering
noremap <Leader>r :set relativenumber!<CR>

" Insert <Tab> or complete identifier if the cursor is after a keyword
" character.
function! TabOrComplete()
  let col = col('.')-1
  if !col || getline('.')[col-1] !~ '\k'
    return "\<tab>"
  else
    return "\<C-N>"
  endif
endfunction
inoremap <Tab> <C-R>=TabOrComplete()<CR>

" Command-line editing like bash/emacs.
cnoremap <C-A>  <Home>
cnoremap <C-F>  <Right>
cnoremap <C-B>  <Left>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <C-U>  <C-E><C-U>

" Open .vimrc in a new tab
noremap <Leader>v :tabedit $MYVIMRC<CR>
" Source the .vimrc file when it's written
autocmd! BufWritePost .vimrc source $MYVIMRC

" Enforce the default color scheme.
colorscheme default

" Customize the tab line colors so that it's easier (for me) to tell which tab
" is active.
highl TabLine term=none cterm=none ctermfg=White ctermbg=DarkGray
highl TabLineFill term=none cterm=none ctermfg=White ctermbg=DarkGray
highl TabLineSel ctermfg=Green

" Highlight matching bracket to bracket under the cursor using something that
" will work more often without being too distracting.
highl MatchParen cterm=underline ctermfg=Red ctermbg=none

" Spelling.
highl SpellBad cterm=undercurl ctermbg=none ctermfg=Red
highl SpellCap cterm=undercurl ctermbg=none ctermfg=DarkBlue
highl SpellRare cterm=undercurl ctermbg=none ctermfg=Brown
highl SpellLocal cterm=undercurl ctermbg=none ctermfg=DarkCyan

" Default indentation.
Tab 2

" Allow an environment-aware vimrc set up by rcm to override anything in this
" one.
let s:local_path = expand("~/.local/etc/vimrc.local")
if filereadable(s:local_path)
  exec "source " . s:local_path
endif
