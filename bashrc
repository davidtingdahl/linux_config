# Some handy aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=always'
alias grep2='grep'
alias less='less -R'
alias zack='ack-grep --ignore-dir build --ignore-dir external'
alias octave='octave --no-gui'
alias git_commit_review='rm -f $(git rev-parse --show-toplevel)/.git/SQUASH_MSG; git commit'

# Setup git prompt
source ~/linux_config/gitprompt.sh
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"

# Setup host-dependant prompt
if [ -f /.dockerenv ];
then
    hostcol='\e[30;1m'
else
    HOSTNAME=$(hostname)
    hostcol='\e[36;1m'
fi

export PS1="\[${hostcol}\]${HOSTNAME} \[\e[37;1m\]\D{%H:%M}\[\e[32;1m\] \w\[\e[37;1m\]\$(__git_ps1)\n\$?> \[\e[0m\]"

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

export PATH="$PATH":"$HOME"/linux_config/scripts
