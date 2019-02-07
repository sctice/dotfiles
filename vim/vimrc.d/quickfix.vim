" Any time a quickfix command is executed, open the quickfix / location window
" when there's something to display there. If the window is already open and
" there are no recognized errors, close the window.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
