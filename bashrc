# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vdw='cd ~/Clients/VDW'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias o="xdg-open"
alias r="rsync -rltD --progress --exclude='*.swp' --exclude='*.bak'"
ls='ls --color=auto'

export PS1="\n\[\033[1;36m\]\u\[\033[1;37m\] \[\033[0;36m\]`date`\n\[\033[0m\][\[\033[1;33m\]\w\[\033[0m\]] "

# Derek Wyatt's Directory Stack
# https://gist.github.com/1154129
export DIRSTACK_MAX=15
DS=()

function eecho
{
    echo $@ 1>&2
}

function shiftStackUp
{
  typeset num=$1
  typeset -i c=$((num+1))

  while (( $c < ${#DS[*]} ))
  do
    DS[$((c-1))]="${DS[$c]}"
    ((c=c+1))
  done
  unset DS[$((${#DS[*]}-1))]
}

function shiftStackDown
{
  typeset num=$1
  typeset -i c=${#DS[*]}

  while (( $c > $num ))
  do
    DS[$c]="${DS[$((c-1))]}"
    ((c=c-1))
  done
}

function popStack
{
  if [[ ${#DS[*]} == 0 ]]; then
    eecho "Cannot pop stack.  No elements to pop."
    return 1
  fi
  typeset retv="${DS[0]}"
  shiftStackUp 0

  echo $retv
}

function pushStack
{
  typeset newvalue="$1"
  typeset -i c=0

  while (( $c < ${#DS[*]} ))
  do
    if [[ "${DS[$c]}" == "$newvalue" ]]; then
      shiftStackUp $c
    else
      ((c=c+1))
    fi
  done
  shiftStackDown 0
  DS[0]="$newvalue"
  if [[ ${#DS[*]} -gt $DIRSTACK_MAX ]]; then
    unset DS[$((${#DS[*]}-1))]
  fi
} 

function cd_
{
  typeset ret=0

  if [ $# == 0 ]; then
    pd "$HOME"
    ret=$?
  elif [[ $# == 1 && "$1" == "-" ]]; then
    pd
    ret=$?
  elif [ $# -gt 1 ]; then
    typeset from="$1"
    typeset to="$2"
    typeset c=0
    typeset path=
    typeset x=$(pwd)
    typeset numberOfFroms=$(echo $x | tr '/' '\n' | grep "^$from$" | wc -l)
    while [ $c -lt $numberOfFroms ]
    do
        path=
        typeset subc=$c
        typeset tokencount=0
        for subdir in $(echo $x | tr '/' '\n' | tail -n +2)
        do
            if [[ "$subdir" == "$from" ]]; then
                if [ $subc -eq $tokencount ]; then
                    path="$path/$to"
                    subc=$((subc+1))
                else
                    path="$path/$from"
                    tokencount=$((tokencount+1))
                fi
            else
                path="$path/$subdir"
            fi
        done
        if [ -d "$path" ]; then
            break
        fi
        c=$((c=c+1))
    done
    if [ "$path" == "$x" ]; then
        echo "Bad substitution"
        ret=1
    else
        pd "$path"
        ret=$?
    fi
  else
    pd "$1"
    ret=$?
  fi

  return $ret
} 

function pd
{
  typeset dirname="${1-}"
  typeset firstdir seconddir ret p oldDIRSTACK

  if [ "$dirname" == "" ]; then
    firstdir=$(pwd)
    if [ ${#DS[*]} == 0 ]; then
      eecho "Stack is empty.  Cannot swap."
      return 1
    fi
    seconddir=$(popStack)
    pushStack "$firstdir"
    "cd" "$seconddir"
    ret=$?
    return $ret
  else
    if [ -d "$dirname" ]; then
      if [ "$dirname" != '.' ]; then
        pushStack "$(pwd)"
      fi
      "cd" "$dirname"
      ret=$?
      return $ret
    else
      eecho "bash: $dirname: not found"
      return 1
    fi
  fi
} 

function ss
{
  typeset f x
  typeset -i c=0
  typeset re="${1-}"

  while (( $c < ${#DS[*]} ))
  do
    f=${DS[$c]}
    if [[ -n "$re" && "$(echo $f | grep $re)" == "" ]]; then
      ((c=c+1))
      continue
    fi
    if (( ${#f} > 120 )); then
      x="...$(echo $f | cut -c$((${#f}-120))-)"
    else
      x=$f
    fi
    echo "$((c+1))) $x"
    ((c=c+1))
  done
} 

function csd
{
  typeset num=${1-}
  typeset removedDirectory

#  if [ "${num##+([0-9])}" != "" ]; then
  if [ "$(echo $num | sed 's/^[0-9]*$//')" != "" ]; then
    c=0
    re=$num
    num=0
    while [ "$c" -lt "${#DS[*]}" ]
    do
      if echo "${DS[$c]}" | grep -q $re; then
        num=$(($c+1))
        break
      fi
      ((c=c+1))
    done
  fi
  if [ "$num" == 0 ]; then
    echo "usage: csd <number greater than 0 | regular expression>"
    return 1
  elif [ "$num" -gt "${#DS[*]}" ]; then
    echo "$num is beyond the stack size."
    return 1
  else
    num=$((num-1))
    typeset dir="${DS[$num]}"
    shiftStackUp $num
    cd_ "$dir"
    return $?
  fi
} 

alias cd=cd_
