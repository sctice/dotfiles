# See our commmon bash_profile for a more complete explanation of the division
# between bash_profile and bashrc. The short version is that this file will be
# executed for each new interactive shell, BUT it will also be executed for the
# shell created by scp.

# Functions

# Join argument 2... with argument 1. Supports multi-character arguments.
implode() {
  local d="$1"; shift
  echo -n "$1"; shift
  printf "%s" "${@/#/$d}";
}

# Remove duplicate entries from a pathlist while maintaining the order. The
# short argument names are required on macOS and '-' argument to paste are
# required on macOS.
unique_pathlist() {
  tr ':' "\n" <<<"$1" \
    | cat -n \
    | sort --key 2 --unique \
    | sort --numeric \
    | cut -f2 \
    | paste -sd: -
}

# Exports

# Add user-specific executables to the path
export PATH="${HOME}/.local/bin:${PATH}"

# Don't add duplicates or any line that begins with whitespace to history.
export HISTCONTROL="ignoredups:ignorespace:erasedups"

export RIPGREP_CONFIG_PATH="$HOME/.config/ripgreprc"

# Allow local bashrcs to override settings from above. Note the process
# substitution to avoid a pipeline, which would cause the loop body to happen
# in a subshell, where it wouldn't affect *this* shell.
while read local_bashrc; do
  source "$local_bashrc"
done < <(find ~/.local/etc/ -name 'bashrc.*')

# Separate out configuration for interactive shells. It's not sufficient to put
# interactive config in bash_profile because that's only executed for login
# shells, and many new shells (e.g., those spawned by tmux) are interactive but
# not login.
case "$-" in
  *i*)
    source ${HOME}/.local/etc/bashrc.interactive
    while read local_interactive_bashrc; do
      source "$local_interactive_bashrc"
    done < <(find ~/.local/etc/ -name 'bashrc.interactive.*')
    ;;
esac

# vim: sw=2 ts=2 sts=2 ft=sh
