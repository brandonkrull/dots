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
export UNAME=$(uname)
#export TERM=xterm

eval "$(thefuck --alias)"
alias ll='ls -lhrt'
alias ..='cd ..' 
alias diff='colordiff'
alias model12='ssh -X bkrull@model12.ps.uci.edu'
alias gp1='ssh -X bkrull@gplogin1.ps.uci.edu'
alias gp2='ssh -X bkrull@gplogin2.ps.uci.edu'
alias gp3='ssh -X bkrull@gplogin3.ps.uci.edu'
alias eos='ssh -X eos03.bc.rzg.mpg.de'
alias bd=". bd -s"
alias ssh='TERM=xterm ssh'
alias v='vim'
alias math='/Applications/Mathematica.app/Contents/MacOS/WolframKernel'

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
    export TRASH=~/.Trash/
    export DROPBOX=~/Dropbox/
    export EMACS=/usr/local/bin/emacs
    export SYSN=i686-apple-darwin9
    color_prompt=yes
    PS1="[\[\e[32;1m\]\H \[\e[0m\]\w]\$(git-branch-prompt)\$ "

    alias emacs='/usr/local/Cellar/emacs-mac/emacs-24.5-z-mac-5.9/bin/emacs-24.5'
    alias em='open -a Emacs.app'
    alias log='em $HOME/Dropbox/bin/orgs/phd.org'
    alias sed='gsed'
    alias serve=''

    source /opt/intel/bin/compilervars.sh intel64 
    TURBOIMG=$HOME/devel/apps/TURBOIMG
    TURBODIR=$HOME/devel/apps/lrsh
    PATH=$HOME/anaconda/bin:$TURBODIR/bin/$SYSN:$TURBOIMG/bin/$SYSN:/usr/local/bin:$HOME/Dropbox/bin:$HOME/bin:$PATH
    export TURBOIMG TURBODIR PATH 
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
    color_prompt=yes
    PS1="[\[\e[31;1m\]\H \[\e[0m\]\w]\$(git-branch-prompt)\$ "

    BASHRC=$HOME/.bashrc
    WORK=/work/bkrull
    TURBOIMG=$WORK/apps/TURBOIMG
    PATH=$HOME/anaconda/bin:$TURBOIMG/bin/em64t-unknown-linux-gnu:$TURBOIMG/scripts:$PATH
    export BASHRC WORK TURBOIMG PATH
    alias log='emacs -nw $HOME/Dropbox/bin/orgs/phd.org'
    alias backupgp='rsync -rt --max-size=50m gplogin2:~/calcs/ ~/calcs/ &'

    function ev { evince $1 &>/dev/null& }
    function mol { molden $1 &>/dev/null& }
    function tl {
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
export PATH=/Users/bkrull/bin/anaconda/bin:/bin:/usr/bin:/usr/sbin:/usr/local/bin/:/Applications/Atom.app/Contents/Resources/app/apm/bin:/usr/local/bin:/Users/bkrull/Dropbox/bin:/Users/bkrull/bin:/opt/intel/composer_xe_2015.3.187/bin/intel64:/opt/local/bin:/opt/local/sbin:/Users/bkrull/bin/:/opt/X11/bin:/usr/local/MacGPG2/bin:/Library/TeX/texbin:/Users/bkrull/Dropbox/bin:/opt/intel/composer_xe_2015.3.187/debugger/gdb/intel64/bin

PATH="/Users/bkrull/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/bkrull/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/bkrull/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/bkrull/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/bkrull/perl5"; export PERL_MM_OPT;
