# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias R='R --no-save'


fastfetch

#
# Prompts
#

# Source git prompt helper
[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ] && \
    . /usr/share/git-core/contrib/completion/git-prompt.sh

PS1='[\u@\h \W]\$ '
# enable git prompt (show branch name in prompt)
# see arch wiki for git for details
# \u@\h is colored green; \W and git branch remain in default color
if declare -F __git_ps1 >/dev/null 2>&1 ; then
    PS1='[\[\e[32m\]\u@\h\[\e[0m\] \W$(__git_ps1 " (%s)")]\$ '
else
    PS1='[\[\e[32m\]\u@\h\[\e[0m\] \W]\$ '
fi

export GIT_PS1_SHOWDIRTYSTATE=1       # shows * for unstaged, + for staged changes
export GIT_PS1_SHOWUNTRACKEDFILES=1   # shows % for untracked files
export GIT_PS1_SHOWUPSTREAM="auto"    # shows < > = relative to upstream
