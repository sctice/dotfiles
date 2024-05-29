if exists("g:neovide")
  " Works with neovide, not with neovim-qt
  set guifont=Iosevka:h11

  let g:neovide_padding_top = 5
  let g:neovide_padding_right = 5
  let g:neovide_padding_left = 5

  let g:neovide_hide_mouse_when_typing = v:true

  let g:neovide_scroll_animation_length = 0.05
  let g:neovide_cursor_animation_length = 0.03
endif

" We rely on the window title containing the current working directory in order to switch to an
" already-open notes instance.
set title
augroup dirchange
    autocmd!
    autocmd DirChanged * let &titlestring=v:event['cwd']
augroup END
