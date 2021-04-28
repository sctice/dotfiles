# Bail early if the terminal isn't interactive or we don't find `fzf`.
if [[ $- != *i* ]] || ! hash fzf 2>/dev/null; then
  return
fi

# To find files for FZF, use our custom script that uses git ls-files in git
# repos and falls back to using find, passing the results in either case
# through `squelch`.
export FZF_DEFAULT_COMMAND=flist-git

bind '"\C-r": "\C-x1\e^\er"'
bind -x '"\C-x1": __fzf_history';

__fzf_history () {
  __ehc $(history | fzf --tac --tiebreak=index | perl -ne 'm/^\s*([0-9]+)/ and print "!$1"')
}

__ehc() {
  if [[ -n $1 ]]; then
    bind '"\er": redraw-current-line'
    bind '"\e^": magic-space'
    READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${1}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
    READLINE_POINT=$(( READLINE_POINT + ${#1} ))
  else
    bind '"\er":'
    bind '"\e^":'
  fi
}
