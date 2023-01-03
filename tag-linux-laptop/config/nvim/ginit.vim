GuiFont! Iosevka\ Fixed:h11

" We rely on the window title containing the current working directory in order to switch to an
" already-open notes instance.
set title
augroup dirchange
    autocmd!
    autocmd DirChanged * let &titlestring=v:event['cwd']
augroup END
