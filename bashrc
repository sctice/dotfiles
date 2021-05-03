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

# Expands simple text tokens in the passed-in string into a prompt
# specification suitable for setting as PS1, PS2, and so on. For window and tab
# titles: the tab title follows '\e]1;', the window title follows '\e]2;', and
# '\a' ends a title.
expand_prompt() {
  read -r -d '' script <<-'EOF'
	{
	  s/<WIN>/\\[\\e]1;\\u@\\h\\a\\e]2;\\a\\]/g
	  s/<NUL>/\\[\\033[0m\\]/g
	  s/<FG>/\\[\\033[m\\]/g
	  s/<\([^>]*\)>/\\[\\033[\1\\]/g
	}
	EOF

  sed -e "$script" <<<"$1"
}

# Exports

# Add user-specific executables to the path
export PATH="${HOME}/.local/bin:${PATH}"

# Set the main and continuation prompts. The <WIN> business sets window and tab
# titles with each new prompt. We do this because systems often do this
# differently, and we'd like the same style across terminal tabs when some are
# local and others are connected to a remote host.
export MY_PS1=$(expand_prompt '<WIN><32m>\A <33m>\u<35m>@<33m>\h <34m>\W <1;31m>[\j] <FG>❯<NUL> ')
export PS1="$MY_PS1"
export MY_PS2=$(expand_prompt '<33m>...<FG>❯<NUL> ')
export PS2="$MY_PS2"

# Explicitly set the editor so git (and others) will use our own vim.
export EDITOR=$(which vim)

# Don't add duplicates or any line that begins with whitespace to history.
export HISTCONTROL="ignoredups:ignorespace:erasedups"

# Make less process control characters, quit if the input is less than a screen
# full, not clear the screen initially, and always wrap long lines.
export PAGER='less'
export LESS='-R -F -X -+S'

# Set up fzf.
source $HOME/.local/etc/fzf.sh

# Set up z and zz.
source $HOME/.local/etc/z.sh

export RIPGREP_CONFIG_PATH="$HOME/.config/ripgreprc"

# Aliases

alias ll='ls -l'

# Allow local bashrcs to override settings from above. Note the process
# substitution to avoid a pipeline, which would cause the loop body to happen
# in a subshell, where it wouldn't affect *this* shell.
while read local_bashrc; do
  source "$local_bashrc"
done < <(find ~/.local/etc/ -name 'bashrc.*')

# vim: sw=2 ts=2 sts=2 ft=sh
