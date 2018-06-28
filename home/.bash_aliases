alias ls="BLOCK_SIZE=\'1 ls -G"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias gb='git branch -a -v'
alias gs='git status'
alias gd='git diff'

function gc {
 if [ -z "$1" ]; then
     git checkout master
 else
     git checkout $1
 fi
}
