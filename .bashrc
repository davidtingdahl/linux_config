# Some handy aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Setup git prompt
source ~/linux_config/gitprompt.sh
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"

# Setup host-dependant prompt
host=$(hostname)
usercol="92" # Away colors
hostcol="93"

if [ $host == "freja" ] || [ $(echo $host | grep fpc-algo) ]
then
    usercol="34" # Home colors
    hostcol="36"
fi
export PS1="\[\e[${usercol};1m\]\u\[\e[37;1m\]@\[\e[${hostcol};1m\]\h\[\e[32;1m\] \w\[\e[37;1m\]\$(__git_ps1)\n\$?> \[\e[0m\]"

# Bash completion
if [ -f /etc/bash_completion ]
then
    source /etc/bash_completion
fi

# Emacs as default editor
which emacs > /dev/null
if [ $? == 0 ]
then
    export EDITOR="emacs"
fi

