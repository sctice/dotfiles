"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Shawn Tice, with lots of help from the internet.

set guioptions=Mm         " No toolbar in the gui; must be first in .vimrc
set nocompatible          " No compatibility with vi

filetype on               " Recognize syntax by file extension
filetype indent on        " Check for indent file
filetype plugin on        " Allow plugins to be loaded by file type
syntax on                 " Syntax highlighting

set autoindent            " By default, match indent of previous line
set autowrite             " Write before executing the 'make' command
set backspace=2           " Allow <BS> to go past last insert
set colorcolumn=+1        " Draw a line to mark the text width visually
set cryptmethod=blowfish  " Use blowfish encryption instead of zip
set expandtab             " Expand tabs with spaces
set gdefault              " Assume :s uses /g
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle initialization

let s:bundles_path = expand("~/.local/etc/vimrc.bundles")
if filereadable(s:bundles_path)
  exec "source " . s:bundles_path
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF configuration

" Add FZF's built-in vim plugin
let s:fzf_path = expand("~/.local/lib/fzf")
if isdirectory(s:fzf_path)
  set runtimepath+=~/.local/lib/fzf
  noremap <Leader>f :FZF<CR>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ctrl-P configuration

let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_lazy_update = 150
let g:ctrlp_match_window = 'bottom,order:ttb,min:10,max:10,results=30'
let g:ctrlp_max_files = 0
let g:ctrlp_open_new_file = 't'
let g:ctrlp_working_path_mode = 0

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

noremap <Leader>b :CtrlPBuffer<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Simple plugin configuration

" Don't remember positions in commit messages.
let g:restorepos_ignore = ['COMMIT_EDITMSG']

" Enable matchit
runtime macros/matchit.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" New commands

" Use sudo to save the current file
command! WW w !sudo tee % >/dev/null

" Open a new, empty tab quickly
command! T tabedit

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings

" Thou shalt not arrow
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

" Yank the entire document to the clipboard
noremap <Leader>Y :%yank+<CR>

" Toggle paste mode
noremap <Leader>p :set paste! paste?<CR>

" Toggle auto-formatting of paragraphs
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

" Toggle highlighting of the last search
noremap <Leader>h :set hlsearch! hlsearch?<CR>

" Open a scratch buffer in a split
noremap <Leader>s :Sscratch<CR>

" Toggle relative numbering and normal line numbering
noremap <Leader>r :set relativenumber!<CR>

" Open .vimrc in a new tab
noremap <Leader>v :tabedit $MYVIMRC<CR>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto commands

" Source the .vimrc file when it's written
autocmd! BufWritePost .vimrc source $MYVIMRC

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color scheme

colorscheme default

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight colors

" Tab line
highl TabLine term=none cterm=none ctermfg=White ctermbg=DarkGray
highl TabLineFill term=none cterm=none ctermfg=White ctermbg=DarkGray
highl TabLineSel ctermfg=Green


" Matching bracket to bracket under the cursor
highl MatchParen cterm=underline ctermfg=Red ctermbg=none

" Spelling
highl SpellBad cterm=undercurl ctermbg=none ctermfg=Red
highl SpellCap cterm=undercurl ctermbg=none ctermfg=DarkBlue
highl SpellRare cterm=undercurl ctermbg=none ctermfg=Brown
highl SpellLocal cterm=undercurl ctermbg=none ctermfg=DarkCyan

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local override and tabbing behavior

" Set up tab expansion given a number of spaces per tab, either locally or
" globally. It would be nice if we could just set 'tabstop' and have
" 'shiftwidth' and 'softtabstop' respect that setting, but some indent scripts
" explicit set 'shiftwidth' and 'softtabstop' to values other than 0, which
" breaks the default behavior.
function! SetTabbing(spaces_per_tab, setcmd)
  execute a:setcmd . " shiftwidth=" . a:spaces_per_tab
  execute a:setcmd . " tabstop=" . a:spaces_per_tab
  execute a:setcmd . " softtabstop=" . a:spaces_per_tab
endfunction
command! -nargs=1 Tab call SetTabbing(<args>, "set")
command! -nargs=1 TabLocal call SetTabbing(<args>, "setlocal")

Tab 2

let s:local_path = expand("~/.local/etc/vimrc.local")
if filereadable(s:local_path)
  exec "source " . s:local_path
endif
