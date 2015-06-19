#-------------------------------------------------------------------------------
# .bashrc
#
# @a brandon krull
# @e btkrull@gmail.com
# @d ca. 2011???
#------------------------------------------------------------------------------- 
shopt -s checkwinsize
shopt -s histappend
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#Global-------------------------------------------------------------------------
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export BASHPROFILE=~/.bash_profile 
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin/:~/bin/:$PATH:~/Dropbox/bin
export EDITOR=/usr/bin/vim
export BASHRC=~/.bash_profile
export VIMRC=~/.vimrc
export TRASH=~/.Trash/
export DROPBOX=~/Dropbox/
export EMACS=/usr/bin/emacs 
export UNAME=$(uname)
export TERM=xterm

alias ll='ls -lhrt'
alias ..='cd ..' 
alias diff='colordiff'
alias model12='ssh -X bkrull@model12.ps.uci.edu'
alias gp1='ssh -X bkrull@gplogin1.ps.uci.edu'
alias gp2='ssh -X bkrull@gplogin2.ps.uci.edu'
alias gp3='ssh -X bkrull@gplogin3.ps.uci.edu'
alias bd=". bd -s"
alias ssh='TERM=xterm ssh'
alias v='vim'

#GIT----------------------------------------------------------------------------
source ~/.git-completion.bash

function git-branch-name {
  git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3
}

function git-branch-prompt {
  local branch=`git-branch-name`
    if [ $branch ]; then printf " [%s]" $branch; fi
}

#Arch-dep-----------------------------------------------------------------------
if [ "$UNAME" == "Darwin" ]; then
#    case "$TERM" in
#        xterm*|rxvt*)
            color_prompt=yes
            PS1="[\[\e[32;1m\]\H \[\e[0m\]\w]\$(git-branch-prompt)\$ "
#            ;;
#        *)
#        ;;
#    esac

    alias log='emacs $HOME/Dropbox/bin/orgs/phd.org'

    source /opt/intel/bin/compilervars.sh intel64 
    export TURBOIMG=$HOME/devel/apps/TURBOIMG
    export TURBODIR=$HOME/devel/apps/lrsh
    source $TURBODIR/Config_turbo_env
    export PATH=$TURBODIR/bin/`sysname`/:$TURBOIMG/bin/`sysname`:/usr/local/bin:$HOME/Dropbox/bin:$HOME/bin:$PATH
    ulimit -s hard

elif [ "$UNAME" == "Linux" ]; then
    if [ -x /usr/bin/dircolors ]; then
        eval "`dircolors -b`"
        alias ls='ls --color=auto'
        alias dir='dir --color=auto'
        alias vdir='vdir --color=auto'

        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi
#    case "$TERM" in
#        xterm*|rxvt*)
            color_prompt=yes
            PS1="[\[\e[31;1m\]\H \[\e[0m\]\w]\$(git-branch-prompt)\$ "
#            ;;
#        *)
#        ;;
#    esac

    BASHRC=$HOME/.bashrc
    WORK=/work/bkrull
    TURBOIMG=$WORK/apps/TURBOIMG
    PATH=$TURBOIMG/bin/em64t-unknown-linux-gnu:$TURBOIMG/scripts:$PATH
    export BASHRC WORK TURBOIMG PATH
    alias log='emacs -nw $HOME/Dropbox/bin/orgs/phd.org'
    alias backupgp='rsync -rt --max-size=50m gplogin2:~/calcs/ ~/calcs/ &'

    function ev { evince $1 &>/dev/null& }
    function mol { molden $1 &>/dev/null& }
    function tl {
        module load intel
        ulimit -s unlimited
        case "$1" in
            0 ) 
                ls --ignore TURBOIMG $WORK/apps 
                unset TURBODIR 
                ;;
            1 )
                export TURBODIR=$WORK/apps/lrsh
                cd $TURBODIR
                source Config_turbo_env
                export PATH=$(pwd):$PATH
                ;;
            2 ) 
                export TURBODIR=$WORK/apps/mpgrad
                cd $TURBODIR
                source Config_turbo_env
                export PATH=$(pwd):$PATH
                ;;
            x ) 
                export TURBODIR=$TURBOIMG
                source $TURBODIR/Config_turbo_env
                export PATH=$(pwd):$PATH
                ;;
        esac } 
else
    case "$TERM" in
        xterm*|rxvt*)
            color_prompt=yes
            PS1="[\[\e[35;1m\]\H \[\e[0m\]\w]\$(git-branch-prompt)\$ "
            ;;
        *)
        ;;
    esac 
fi 
