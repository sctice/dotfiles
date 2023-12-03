# Bail early if the terminal isn't interactive or we don't find `fzf`.
if [[ $- != *i* ]] || ! hash fzf 2>/dev/null; then
  return
fi

# To find files for FZF, use our custom script that allows easily toggling ignores and uses ripgrep
# if it's available.
export FZF_DEFAULT_COMMAND=flist-git

bind '"\C-r": "\C-x1\e^\er"'
bind -x '"\C-x1": __fzf_history';

__fzf_history() {
  __fzf_redraw $(history | fzf --tac --tiebreak=index | perl -ne 'm/^\s*([0-9]+)/ and print "!$1"')
}

__fzf_redraw() {
  if [[ -n $1 ]]; then
    bind '"\er": redraw-current-line'
    bind '"\e^": history-expand-line'
    READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${1}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
    READLINE_POINT=$(( READLINE_POINT + ${#1} ))
  else
    bind '"\er":'
    bind '"\e^":'
  fi
}

# Ctrl-x e to list all executables in path
bind '"\C-xe": "\C-xe!\er"'
bind -x '"\C-xe!": __fzf_exec';

__fzf_exec() {
  __fzf_redraw $(compgen -c -o nosort | uniq | fzf --tiebreak=index)
}
