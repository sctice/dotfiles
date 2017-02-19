# Bash is supposed to run this file for login shells. What's a login shell?
# That depends. The following are all login shells (unless configured
# otherwise):
#
# - The shell launched by sshd for you when logging into a remote server
# - The shell launched by Terminal.app for each tab
# - The shell launched for tty{1,2,...} on Linux (NOT graphical terminals)
#
# The above means that this file will usually be run for new terminals and
# connections but NOT on Linux, where it won't be run any time a new graphical
# terminal (e.g., xterm) is opened. For new graphical terminals on Linux, the
# bashrc will be run. This situation prompts us to put a lot of configuration
# in bashrc, then source it from this file so that we can ensure that it will
# be run for EVERY interactive shell session. The only exceptions would be
# commands that are only applicable to login (but will show up for every new
# tab in Terminal.app): displaying a banner, usage statistics, and so on.
#
# One caveat to the above is that bash executes bashrc for non-interactive
# shells if the parent process is sshd or rshd. The effect is that the shell
# launched by scp will execute bashrc, so there shouldn't be any commands there
# that produce output or use commands that expect a proper tty (e.g., stty).

# Include settings for non-login shells. Do this first so we can override
# settings specific to a login shell.
if [ -r ~/.bashrc ]; then
  source ~/.bashrc
fi

# Put anything in here that you'd like to run on login (a new SSH session or
# when booting a Linux machine), but not when opening a new terminal emulator
# session (e.g., new xterm, new Terminal.app tab). This is untested with iTerm
# and friends.
if [ uname != "Darwin" ]; then
  : # Nothing here yet.
fi

# Disable sending of START/STOP signals. This needs to be here, where we know
# we have an interactive shell, since bash executes bashrc for children of
# sshd and thus scp, which doesn't have a tty.
stty -ixon

# Allow local bash_profile to override settings from above.
if [ -r ~/.local/etc/bash_profile.local ]; then
  source ~/.local/etc/bash_profile.local
fi

# vim: sw=2 ts=2 sts=2 ft=sh
