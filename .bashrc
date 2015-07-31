# some handy aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Function for displaying a git branch in the prompt
  parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
  }

  parse_git_branch_or_tag() {
    local OUT="$(parse_git_branch)"
    echo "$OUT"
  }

#Colorful bash prompt with git
export PS1="\[\e[34;1m\]\u\[\e[37;1m\]@\[\e[36;1m\]\h\[\e[32;1m\] \w\[\e[37;1m\]\$(parse_git_branch_or_tag)\n> \[\e[0m\]"

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

