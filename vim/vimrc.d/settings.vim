" General settings that apply nearly everywhere.

set guioptions=Mm         " No toolbar in the GUI; must be first in .vimrc
set nocompatible          " No compatibility with vi

let &t_ut=''              " Fix vim background redraw in kitty terminal

filetype on               " Recognize syntax by file extension
filetype indent on        " Check for indent file
filetype plugin on        " Allow plugins to be loaded by file type
syntax on                 " Syntax highlighting

set autoindent            " By default, match indent of previous line
set backspace=2           " Allow <BS> to go past last insert
set colorcolumn=+1        " Draw a line to mark the text width visually
set expandtab             " Expand tabs with spaces
set gdefault              " Assume :s uses /g
set hidden                " Allow hiding abandoned buffers
set ignorecase            " Ignore case in regular expressions
set incsearch             " Immediately highlight search matches
set laststatus=2          " Always show a status line
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
set textwidth=99          " Hard wrap at 99 characters
set timeoutlen=250        " Time (ms) to wait for mapped sequences
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
