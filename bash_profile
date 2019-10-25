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
export TERM=xterm-256color

alias ll='ls -lhrt'
alias ..='cd ..' 
alias diff='colordiff'
alias bd=". bd -s"
alias ssh='TERM=xterm ssh'
alias v='vim'

#GIT----------------------------------------------------------------------------
source ~/.git-completion.bash
alias git=hub

function git-branch-name {
  git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3
}

function git-branch-prompt {
  local branch=`git-branch-name`
    if [ $branch ]; then printf " [%s]" $branch; fi
}

#Arch-dep-----------------------------------------------------------------------
color_prompt=yes
export TRASH=~/.Trash/
export SYSN=i686-apple-darwin9
export PROMPT_DIRTRIM=3
color_prompt=yes
PS1="[\[\e[32;1m\]\u \[\e[0m\]\W]\$(git-branch-prompt)\$ "

alias sed='gsed'
alias ctags='/usr/local/bin/ctags'
alias ctags-exuberant='/usr/local/bin/ctags'

# added by Anaconda3 5.3.0 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
# . "/anaconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

function em {
    emacsclient -n -e "(if (> (length (frame-list)) 1) 't)" 2> /dev/null | grep t &> /dev/null
    if [ "$?" -eq "1" ]; then
         emacsclient -a '' -nqc "$@" &> /dev/null
    else
          emacsclient -nq "$@" &> /dev/null
    fi
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/bk/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/bk/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/bk/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/bk/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/usr/local/opt/ruby@2.5/bin:$PATH"
export CPPFLAGS="-I/usr/local/opt/ruby@2.5/include"
export LDFLAGS="-L/usr/local/opt/ruby@2.5/lib"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -d /usr/local/al-scripts/profile.d ]; then
  for config in /usr/local/al-scripts/profile.d/*.sh; do
    if [ -r $config ]; then
      . $config
    fi
  done
fi
export PATH="/usr/local/opt/ruby/bin:$PATH"
