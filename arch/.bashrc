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
if [ -f /usr/share/git/completion/git-completion.bash ]; then
	. /usr/share/git/completion/git-completion.bash
fi

# enable git prompt (see below)
if [ -f /usr/share/git/completion/git-prompt.sh ]; then
	. /usr/share/git/completion/git-prompt.sh
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
alias np='nano PKGBUILD'
alias fixit='sudo rm -f /var/lib/pacman/db.lck && sudo pacman-mirrors -g && sudo pacman -Syyuu  && sudo pacman -Suu'
alias cat='bat'
# alias emacs='LANG=C emacs'

#
# Prompts
#

PS1='[\u@\h \W]\$ '
# enable git prompt (show branch name in prompt)
# see arch wiki for git for details
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
