export BARTIB_FILE="${HOME}/.local/var/activity.bartib"

alias bb=bartib
alias bbs="bartib-start"
alias bbr="bartib-resume"
alias bbl="bartib list --today"
alias bbt="bartib report --today"

bbp() {
  bartib stop "$@" && bartib list --today
}

_bartib() {
  local cmd="$1" cur="$2" prev="$3" subcmd=

  for ((i=1; i < COMP_CWORD; i++)); do
    if [[ ${COMP_WORDS[i]} != -* ]]; then
      subcmd="${COMP_WORDS[i]}"
      break
    fi
  done

  if [[ -z "$subcmd" && "$cur" != -* ]]; then
    # Parse subcommands out of the help.
    COMPREPLY=($(compgen -W '$(bartib --help | awk "/^SUBCOMMANDS/{sc=1;next}sc{print\$1}")' -- "$cur"))
  else
    # Assume that we're completing an option.
    if [[ "$prev" == "--project" ]]; then
      # List projects for the --project argument. This is being careful to handle the quotes around
      # project names, which may contain spaces.
      local projects project_completions
      projects=$(bartib projects)
      local IFS=$'\n'
      project_completions=($(compgen -W "${projects[*]}" -- "$cur"))
      COMPREPLY=($(printf "\"%s\"\n" "${comp_projects[@]}"))
    else
      # Parse flags out of the help (depends on _parse_help from the bash-completions package).
      COMPREPLY=($(compgen -W '$(_parse_help bartib "$subcmd --help")' -- "$cur"))
    fi
  fi
}

# We depend on the _parse_help function from the bash-completion package to do completion, so
# there's no point setting up completion without that.
if type -t _parse_help 2>/dev/null 1>&2; then
  complete -F _bartib bartib
  complete -F _bartib bb
fi
