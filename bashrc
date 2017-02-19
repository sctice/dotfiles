# See our commmon bash_profile for a more complete explanation of the division
# between bash_profile and bashrc. The short version is that this file will be
# executed for each new interactive shell, BUT it will also be executed for the
# shell created by scp.

# Functions

# Remove duplicate entries from a pathlist while maintaining the order.
unique_pathlist() {
  tr ':' "\n" <<<"$1" \
    | cat --number \
    | sort --key 2 --unique \
    | sort --numeric \
    | cut --field 2 \
    | paste --serial --delimiters ':'
}

# Expands simple text tokens in the passed-in string into a prompt
# specification suitable for setting as PS1, PS2, and so on. For window and tab
# titles: the tab title follows '\e]1;', the window title follows '\e]2;', and
# '\a' ends a title.
expand_prompt() {
  read -r -d '' script <<-'EOF'
	{
	  s/<WIN>/\\[\\e]1;\\u@\\h\\a\\e]2;\\a\\]/g
	  s/<BLA>/\\[\\033[30m\\]/g
	  s/<RED>/\\[\\033[31m\\]/g
	  s/<GRE>/\\[\\033[32m\\]/g
	  s/<YEL>/\\[\\033[33m\\]/g
	  s/<BLU>/\\[\\033[34m\\]/g
	  s/<MAG>/\\[\\033[35m\\]/g
	  s/<CYA>/\\[\\033[36m\\]/g
	  s/<WHI>/\\[\\033[37m\\]/g
	  s/<NUL>/\\[\\033[0m\\]/g
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
export MY_PS1=$(expand_prompt '<WIN><CYA>\A <MAG>\h <BLU>\W <RED>[\j]<NUL> ')
export PS1="$MY_PS1"
export MY_PS2='...> '
export PS2="$MY_PS2"

# Explicitly set the editor so git (and others) will use our own vim.
export EDITOR=$(which vim)

# Don't add duplicates or any line that begins with whitespace to history.
export HISTCONTROL="ignoredups:ignorespace"

# Make less process control characters, quit if the input is less than a screen
# full, not clear the screen initially, and always wrap long lines.
export PAGER='less'
export LESS='-R -F -X -+S'

# Aliases

alias ll='ls -l'

# When inside a tmux session, SSH needs to explicitly override the TERM
# environment variable from screen-256color to something that remote servers
# will expect.
if [ -n "$TMUX" ]; then
  alias ssh='TERM=xterm-256color ssh'
fi

# Allow local bashrc to override settings from above.
if [ -r ~/.local/etc/bashrc.local ]; then
  source ~/.local/etc/bashrc.local
fi

# vim: sw=2 ts=2 sts=2 ft=sh
