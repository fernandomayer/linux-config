#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#
# Completions
#

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# enable git commands completion
if [ -f /usr/share/bash-completion/completions/git ]; then
	. /usr/share/bash-completion/completions/git
fi

# enable git prompt (see below)
if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
	. /usr/share/git-core/contrib/completion/git-prompt.sh
fi

# enable dnf commands completion
if [ -f /usr/share/bash-completion/completions/dnf ]; then
	. /usr/share/bash-completion/completions/dnf
fi

# enable sudo completion (completes the subcommand after sudo)
if [ -f /usr/share/bash-completion/completions/sudo ]; then
	. /usr/share/bash-completion/completions/sudo
else
	complete -cf sudo
fi

#
# Exports
#

export EDITOR=/usr/bin/nano

#
# Aliases
#

# alias ls='ls --color=auto'
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias fixit='sudo dnf clean all && sudo dnf update'
alias fehfeh="feh -g 800x600 -Z"
# alias cat='bat'
# alias emacs='LANG=C emacs'
alias R='R --no-save'

fastfetch

#
# Prompts
#

PS1='[\u@\h \W]\$ '
# enable git prompt (show branch name in prompt)
# see arch wiki for git for details
# \u@\h is colored green; \W and git branch remain in default color
if declare -F __git_ps1 >/dev/null 2>&1 ; then
    PS1='[\[\e[32m\]\u@\h\[\e[0m\] \W$(__git_ps1 " (%s)")]\$ '
else
    PS1='[\[\e[32m\]\u@\h\[\e[0m\] \W]\$ '
fi
