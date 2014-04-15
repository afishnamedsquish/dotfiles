# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="candy-kingdom"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
alias unmute="pactl set-sink-mute 0 0"
alias mute="pactl set-sink-mute 0 1"
alias localbstack='java -jar /usr/local/bin/BrowserStackTunnel.jar -f 6UEnhpWM9sCCUiG3pnGx '
alias tmux="TERM=screen-256color-bce tmux"
alias r="rsync -rltD --progress --exclude='*.swp' --exclude='*.bak'"
alias o="xdg-open"
alias g="git"
alias vi="vim"
alias phps="psysh"
alias decrypt="openssl rsautl -decrypt -inkey ~/.ssh/id_rsa -in "
function encrypt {
    openssl rsautl -encrypt -inkey ~/.ssh/id_rsa -in $1 -out $2
}

# projects
alias vtfa="cd ~/sites/vtfa"
alias swim="cd ~/sites/swim"
alias cw="cd ~/sites/contentworks"
alias mw="cd ~/sites/moduleworks"
alias spark="cd ~/sites/sparkles"
alias velco="cd ~/sites/velco"
alias smash="cd ~/sites/smash"
alias bull="cd ~/sites/bull"
alias vdw="cd ~/sites/vtdesign"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git composer symfony2 web-search rand-quote battery jira new_jira)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/home/squizztoupe/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/bin/adt-bundle/sdk/platform-tools:/usr/local/bin/adt-bundle/sdk/tools:/usr/local/bin/apache-ant/bin

# Add to python path
export PYTHONPATH=$PYTHONPATH:$HOME/dotfiles/python

export WORKON_HOME=~/.virtualenvs
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh

VIRTUALENVWRAPPER=$(locate virtualenvwrapper_lazy.sh)
if [ $VIRTUALENVWRAPPER ] 
    then source $VIRTUALENVWRAPPER
fi

VISUAL=vim; export VISUAL
EDITOR=vim; export EDITOR

# When you type a dir name, automatically cd into that dir
setopt autocd

# Enable extended glob behavior
setopt extended_glob

autoload -U zmv
