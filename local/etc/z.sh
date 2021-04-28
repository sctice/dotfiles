z_script="$HOME/.local/lib/z/z.sh"

# Do nothing if the terminal isn't interactive or we don't have `z`.
if [[ $- != *i* || ! -r "$z_script" ]]; then
  return
fi

export _Z_DATA="$HOME/.local/var/z-data"
export _Z_MAX_SCORE=1000
source "$z_script"

# Don't set up `zz` if we don't have `fzf`.
if ! hash fzf 2>/dev/null; then
  return
fi

zz() {
  # Strip away scores before passing paths to fzf, but keep the order we get
  # from `z -l`.
  local dir
  dir=$(
    z -l "${1:-}" \
    | awk '{print $2}' \
    | fzf --query="$1 " --select-1 --exit-0 --tac --no-sort --border --margin 5,10
  ) \
    && echo "$dir" \
    && cd "$dir"
}
