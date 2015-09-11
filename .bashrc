# some handy aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

source ~/linux_config/gitprompt.sh
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"

export PS1="\[\e[34;1m\]\u\[\e[37;1m\]@\[\e[36;1m\]\h\[\e[32;1m\] \w\[\e[37;1m\]\$(__git_ps1)\n> \[\e[0m\]"

#Bash completion
if [ -f /etc/bash_completion ]
then
    source /etc/bash_completion
fi

#Emacs as default editor
which emacs > /dev/null
if [ $? == 0 ]
then
    export EDITOR="emacs"
fi

